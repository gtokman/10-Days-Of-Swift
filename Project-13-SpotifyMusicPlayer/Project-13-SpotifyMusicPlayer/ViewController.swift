//
//  ViewController.swift
//  Project-13-SpotifyMusicPlayer
//
//  Created by g tokman on 4/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - Properties

	var session: SPTSession?
	var player: SPTAudioStreamingController?
	var delegate: SPTAuthViewDelegate?
	private let setClientId = "ad113c3666704e7aa1136d89846d2143"
	private let setRedirectURL = "project-13-spotifymusicplayer://returnafterlogin"

	@IBOutlet weak var loginButton: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	// MARK: - Actions

	@IBAction func loginWithSpotify(sender: UIButton) {

		// Setup
		SPTAuth.defaultInstance().clientID = setClientId
		SPTAuth.defaultInstance().redirectURL = NSURL(string: setRedirectURL)
		SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope]

		// Construct login
		let loginURL = SPTAuth.defaultInstance().loginURL

		UIApplication.sharedApplication().openURL(loginURL)
	}
}

extension ViewController: SPTAuthViewDelegate {

	func authenticationViewController(authenticationViewController: SPTAuthViewController!, didLoginWithSession session: SPTSession!) {

		print("Login success 🤗")
	}

	func authenticationViewController(authenticationViewController: SPTAuthViewController!, didFailToLogin error: NSError!) {

		print("Login error💩: \(error)")
	}

	func authenticationViewControllerDidCancelLogin(authenticationViewController: SPTAuthViewController!) {
		print("Canceled login")
	}
}
