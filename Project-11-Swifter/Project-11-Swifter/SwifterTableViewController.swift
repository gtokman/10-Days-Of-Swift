//
//  SwifterTableViewController.swift
//  Project-11-Swifter
//
//  Created by g tokman on 4/14/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import CloudKit
import SIAlertView

class SwifterTableViewController: UITableViewController {

	// MARK: - Properties

	var sweets = [CKRecord]()
	var refresh: UIRefreshControl!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Refresh
		refresh = UIRefreshControl()
		refresh.attributedTitle = NSAttributedString(string: "Pull to load sweets 😜")
		refresh.addTarget(self, action: #selector(SwifterTableViewController.loadSweetData), forControlEvents: .ValueChanged)
		self.tableView.addSubview(refresh)

		loadSweetData()
	}

	// MARK: - Table view data source

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return sweets.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellIdentifier = "MyCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

		let sweet = sweets[indexPath.row]

		// Get CloudKit data
		if let sweetContent = sweet["content"] as? String {
			let dateFormat = NSDateFormatter()
			dateFormat.dateFormat = "MM/dd/yyyy"
			let dateString = dateFormat.stringFromDate(sweet.creationDate!)

			cell.textLabel?.text = sweetContent
			cell.detailTextLabel?.text = dateString
		}

		return cell
	}

	// MARK: - Actions

	@IBAction func sendSweet(sender: UIBarButtonItem) {

		let alertView = UIAlertController(title: "New Sweet", message: "Say something Sweet 😎", preferredStyle: .Alert)
		alertView.addTextFieldWithConfigurationHandler { (textfield) in
			textfield.placeholder = "Your sweet"
		}

		let sendButton = UIAlertAction(title: "Send", style: .Default) { (action) in
			let textField = alertView.textFields?.first

			// Check textfield has a value
			guard let textFieldText = textField?.text where !textFieldText.isEmpty else {
				print("Textfield is empty 😤")
				return
			}

			// Create database record w/ key "content"
			let newSweet = CKRecord(recordType: "Sweet")
			newSweet["content"] = textFieldText

			// Public data
			let publicData = CKContainer.defaultContainer().publicCloudDatabase
			publicData.saveRecord(newSweet, completionHandler: { (record, error) in

				// Save fail
				guard error == nil else {
					print("Error saving Sweet 😣 Error: \(error)")
					return
				}

				// Save Success
				print("Saved Sweet 😊")
				dispatch_async(dispatch_get_main_queue()) {

					// Update table view with new Sweet
					self.tableView.beginUpdates()
					self.sweets.insert(newSweet, atIndex: 0)
					let indexPath = NSIndexPath(forRow: 0, inSection: 0)
					self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
					self.tableView.endUpdates()
				}
			})
		}

		let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
		alertView.addAction(sendButton)
		alertView.addAction(cancelButton)

		presentViewController(alertView, animated: true, completion: nil)
	}
}

// MARK: - Load CloudKit data

extension SwifterTableViewController {
	func loadSweetData() {

		sweets = [CKRecord]()
		let publicData = CKContainer.defaultContainer().publicCloudDatabase

		// Query data
		let query = CKQuery(recordType: "Sweet", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
		query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

		publicData.performQuery(query, inZoneWithID: nil) { (results, error) in

			// Check for nil
			guard error == nil, let newSweets = results else {
				print("Error loading data 😬 Error: \(error)")
				return
			}

			// Add new Sweets
			self.sweets = newSweets

			// Reload data
			dispatch_async(dispatch_get_main_queue()) {
				self.tableView.reloadData()
				self.refresh.endRefreshing()
			}
		}
	}
}
