//
//  ViewController.swift
//  Project-10-FoodTracker
//
//  Created by g tokman on 4/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	// MARK: - Properties

	@IBOutlet var nameTextField: UITextField!
	@IBOutlet weak var mealNameLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Handle the text filed's user input throgh delegate callbacks
		nameTextField.delegate = self
	}

	// MARK: - UITextFieldDelegate

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		// Hide the keyboard.
		textField.resignFirstResponder()

		return true
	}

	func textFieldDidEndEditing(textField: UITextField) {
		mealNameLabel.text = textField.text
	}

	// MARK: - Actions

	@IBAction func setDefaultLabelText(sender: UIButton) {
		mealNameLabel.text = "Default Text"
	}
}
