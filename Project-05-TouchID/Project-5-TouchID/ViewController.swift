//
//  ViewController.swift
//  Project-5-TouchID
//
//  Created by g tokman on 4/2/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

/*
- Only foreground applications can use Touch ID.
- Policy evaluation may fail.
- The device may not support it.
- The device supports it, but it could be in a lockout state or some other configuration setting preventing its use.
 Your application should provide its own fallback password entry mechanism in the event policy evaluation fails.
 */

import UIKit
import LocalAuthentication

class ViewController: UITableViewController {
    
    // MARK: Properties
    let context = LAContext()
    var error: NSError?
    
    // MARK: Outlets
    
    @IBOutlet var textView: UITextView?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: Setup

extension ViewController {
    
    func authenticate() {
        print("Authentication...")
        
        // No touch ID
        guard context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print("canEvaluatePolicy failed: \(error?.localizedDescription)")
            return
        }
        
        // Touch ID available
        let reason = "Authenticate to login"
        context.evaluatePolicy(.DeviceOwnerAuthentication, localizedReason: reason) { (success, error) in
            
            if success {
                self.printMessage("Authentication success")
                
                // TODO: Update UI on Main Thread
                
            } else {
                if let error = error {
                    self.printMessage("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func printMessage(message: String) {
        dispatch_async(dispatch_get_main_queue()) {
            self.textView?.text = self.textView?.text.stringByAppendingString(message + "\n")
            self.textView?.scrollRangeToVisible(NSMakeRange(self.textView!.text.characters.count - 1, 0))
        }
    }
}

// MARK: Table View Data Source

extension ViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Actions"
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AuthenticateCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Authenticate"
        cell.detailTextLabel?.text = "Local Authentication using Touch ID"
        
        return cell
        
    }
}

// MARK: Table View Delegate

extension ViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        authenticate()
        
    }
}
