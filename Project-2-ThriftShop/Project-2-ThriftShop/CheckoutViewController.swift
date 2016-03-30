//
//  CheckoutViewController.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: Properties
    
    var cartStore: CartStore!
    
    // MARK: Outlets
    
    @IBOutlet var tableView: UITableView? {
        didSet {
            tableView?.separatorInset = UIEdgeInsetsZero
        }
    }
    
    @IBOutlet var buyButton: UIButton? {
        didSet {
            buyButton?.titleLabel?.font = UIFont.latoFontOfSize(24)
        }
    }
    
    // MARK: View Life Cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        refreshTotal()
    }
    
    // Init View Controller
    static func instantiate() -> UIViewController {
        return UIStoryboard(name: "Checkout", bundle: nil).instantiateInitialViewController()!
    }
    
    // MARK: Actions 
    
    @IBAction func buyTapped(sender: UIButton) {
        cartStore.buy()
        
        let alert = UIAlertController(title: "Done", message: "Thank you for buying as Thirft Shop", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default) { _ in
            self.navigationController?.popToRootViewControllerAnimated(false)
        }
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

// MARK: Tableview Data Source

extension CheckoutViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartStore.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let product = cartStore.allProducts()[indexPath.row]
        
        cell.selectionStyle = .None
        cell.textLabel?.font = UIFont.latoLightFontOfSize(15)
        cell.textLabel?.text = product.name
        cell.imageView?.sd_setImageWithURL(product.imageURL)
        
        return cell
    }
}

// MARK: Tableview Delegate

extension CheckoutViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { [weak self] action, index in
            
            guard let product = self?.cartStore.allProducts()[indexPath.row] else {
                return
            }
            
            self?.cartStore.removeProduct(product)
            self?.refreshTotal()
            tableView.reloadData()
        }
        return [delete]
    }
}

// MARK: Get product total

private extension CheckoutViewController {
    func refreshTotal() {
        title = "Total: $\(cartStore.total)"
    }
}