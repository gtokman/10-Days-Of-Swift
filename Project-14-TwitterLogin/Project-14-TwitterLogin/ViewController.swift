//
//  ViewController.swift
//  Project-14-TwitterLogin
//
//  Created by g tokman on 4/17/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Firebase
import XLActionController

class ViewController: UIViewController {

	// MARK: - Properties

	@IBOutlet weak var usernameLable: UILabel?
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView?
	@IBOutlet weak var twitterLoginButton: UIButton?
	@IBOutlet weak var logoutButton: UIButton?
	@IBOutlet weak var imageView: UIImageView!

	// MARK: - Life Cycle

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		firebaseRef.observeAuthEventWithBlock { (authData) in

			guard authData != nil else {
				print("User not authed 😁")
				self.usernameLable?.text = ""
				self.logoutButton?.hidden = true
				return
			}
			print("😙")

			// User auth success
			let twitterUsername = authData.providerData["username"] as? String

			self.usernameLable?.text = "@\(twitterUsername)"
			self.logoutButton?.hidden = false
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	// MARK: - Actions

	@IBAction func didTouchTwitterLogin(sender: UIButton) {
		twitterAuthHelper.selectTwitterAccountWithCallback { (error, accounts) in

			guard error == nil else {
				print("Error retrieving Twitter account: \(error)")
				return
			}

			// User has account
			let actionSheet = UIAlertController(title: "Select Twitter Account", message: nil, preferredStyle: .ActionSheet)
			let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
			actionSheet.addAction(cancelAction)

			for account in accounts {
				let twitterAccountAction = UIAlertAction(title: account.username, style: .Default, handler: { (action) in
					let twitterHandle = action.title

					for account in twitterAuthHelper.accounts {
						if twitterHandle == account.username {
							self.activityIndicator?.startAnimating()

							twitterAuthHelper.authenticateAccount(account as! ACAccount, withCallback: { (error, authData) in
								self.activityIndicator?.stopAnimating()

								guard error == nil else {
									print("User name not authed 😰")
									return
								}

								// Success add to user defaults
								print("User authenticated 😃")
								NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
							})
						}
					}
				})

				actionSheet.addAction(twitterAccountAction)
			}
			self.presentViewController(actionSheet, animated: true, completion: nil)
		}
	}

	@IBAction func didTouchLogoutButton(sender: UIButton) {
		// Unauth user from app
		currentUser.unauth()

		// Remove uid from defaults
		NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
	}
}
