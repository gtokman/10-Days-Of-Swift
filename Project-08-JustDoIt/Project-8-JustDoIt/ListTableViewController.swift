//
//  ListTableViewController.swift
//  Project-8-JustDoIt
//
//  Created by g tokman on 4/9/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var onListSelected: ((list: List) -> Void)?
    var todosDatastore: TodosDatastore?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Actions

extension ListTableViewController {
    @IBAction func addListButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter list name", message: "Tod create a new list, please enter the name of the list", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            let textField = alert.textFields?.first
            self.addList(textField?.text ?? "")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextFieldWithConfigurationHandler(nil)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func addList(description: NSString) {
        todosDatastore?.addListDescription(description as String)
        tableView.reloadData()
    }
}

// MARK: - Table View Delegate

extension ListTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let list = todosDatastore?.lists()[indexPath.row]
        if let list = list, onListSelected = onListSelected {
            onListSelected(list: list)
        }
        navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - Table View Data Source

extension ListTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosDatastore?.lists().count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath)
        
        if let list = todosDatastore?.lists()[indexPath.row] {
            cell.textLabel?.text = list.description
        }
        
        cell.selectionStyle = .None
        
        return cell
    }
}
