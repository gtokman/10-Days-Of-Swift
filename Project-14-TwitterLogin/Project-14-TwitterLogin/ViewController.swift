//
//  ViewController.swift
//  Project-14-TwitterLogin
//
//  Created by g tokman on 4/17/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var twitterLoginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    // MARK: - Actions
    @IBAction func didTouchTwitterLogin(sender: UIButton) {
    }
    
    
    @IBAction func didTouchLogoutButton(sender: UIButton) {
    }
}

