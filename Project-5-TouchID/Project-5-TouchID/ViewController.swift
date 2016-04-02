//
//  ViewController.swift
//  Project-5-TouchID
//
//  Created by g tokman on 4/2/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: Properties
    
    // MARK: Outlets
    
    @IBOutlet var textView: UITableView?

    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
        
        return cell
    }
    
}