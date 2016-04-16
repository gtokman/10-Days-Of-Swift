//
//  RegisterViewController.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import LatoFont

class RegisterViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var emailTextField: UITextField! {
        didSet {
            emailTextField.becomeFirstResponder()
            emailTextField.font = UIFont.latoFontOfSize(18)
        }
    }
    
    @IBOutlet var okButton: UIButton! {
        didSet {
            okButton.enabled = false
            okButton.titleLabel?.font = UIFont.latoFontOfSize(18)
        }
    }
    
    // MARK: Init View Controller
    
    static func instantiate() -> RegisterViewController {
        return UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as! RegisterViewController
    }
    
    // MARK: Actions
    
   
    @IBAction func emailTextFieldChanged(sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        okButton.enabled = text.isValidEmail()
        
    }
    
    
    @IBAction func signinTapped(sender: UIButton) {
        guard let text = emailTextField.text else {
            return
        }
        
        AppDelegate.appdelegate().userStore.setUserEmail(text)
        
        performSegueWithIdentifier("ShowEcommerceScene", sender: self)
        
    }

}
