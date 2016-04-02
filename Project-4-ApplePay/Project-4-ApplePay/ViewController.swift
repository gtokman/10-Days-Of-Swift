//
//  ViewController.swift
//  Project-4-ApplePay
//
//  Created by g tokman on 4/1/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import PassKit
import Stripe

class ViewController: UIViewController {
    
    // MARK: Properties
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let ApplePayMerchantID = "merchant.com.garytokman.stripe"
    var logger: UILogger!
    
    // MARK: Outlets
    
    @IBOutlet var paymentValueField: UITextField?
    @IBOutlet var textArea: UITextView?
    @IBOutlet var payButton: UIButton?
    @IBOutlet var paymentTextField: STPPaymentCardTextField?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logger = UILogger(out: textArea!)
        
        setup()
        
    }
    
    // MARK: Actions
    
    @IBAction func payWithApplePay(sender: UIButton) {
        
        if let total = Double(paymentValueField!.text!) {
            logger.logEvent("Pay with Apple Pay the amount \(total)")
            applePay(total)
        } else {
            logger.logEvent("No valid amount Specified!")
        }
    }
    
}

// MARK: Setup

extension ViewController {
    func setup() {
        paymentTextField = STPPaymentCardTextField()
        paymentTextField?.center = view.center
        view.addSubview(paymentTextField!)
        paymentTextField?.delegate = self
        payButton?.enabled = PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(SupportedPaymentNetworks)
    }
}

// MARK: Apple Pay

extension ViewController {
    func applePay(price: Double) {
        
        // Fake item
        let item = PKPaymentSummaryItem(label: "New Charge", amount: NSDecimalNumber(double: price))
        
        // Request
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePayMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = .Capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [item]
        
        if Stripe.canSubmitPaymentRequest(request) {
            logger.logEvent("Paying with Apple Pay and Stripe!")
            
            // Apple Pay is available and the user created a valid credit card record
            let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
            applePayController.delegate = self
            presentViewController(applePayController, animated: true, completion: nil)
            
        } else {
            logger.logEvent("Cannot submit Apple Pay payments!")
            
            // TODO: Default to Stripe's Payment form
        }
        
    }
}

// MARK: Payment Card TextField Delegate

extension ViewController: STPPaymentCardTextFieldDelegate {
    
    func paymentCardTextFieldDidChange(textField: STPPaymentCardTextField) {
        payButton?.enabled = textField.valid
    }
    
    
    
    
}

// MARK: Payment Auth View Controller Delegate

extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (PKPaymentAuthorizationStatus) -> Void) {
        
        let this = self
        
        // Create token with payment info
        Stripe.createTokenWithPayment(payment) { token, error in
            if let token = token {
            this.logger.logEvent("Got a valid token: \(token)")
            
            // TODO: Handle token to create charge on backend
            
            completion(.Success)
            } else {
                this.logger.logEvent("Did not get a valid token!")
                completion(.Failure)
            }
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}







