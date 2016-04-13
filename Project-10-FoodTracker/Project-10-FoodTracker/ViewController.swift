//
//  ViewController.swift
//  Project-10-FoodTracker
//
//  Created by g tokman on 4/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	// MARK: - Properties

	@IBOutlet var nameTextField: UITextField!
	@IBOutlet weak var mealNameLabel: UILabel!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingController!

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

	// MARK: - UIImagePickerControllerDelegate

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		// Dismiss the picket if the user canceled.
		dismissViewControllerAnimated(true, completion: nil)
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
		// Te info dictionary contains multiple representations of the image, and this uses the original.
		let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage

		// Set photoImageView to display the selected image.
		photoImageView.image = selectedImage

		// Dimiss the picker.
		dismissViewControllerAnimated(true, completion: nil)
	}

	// MARK: - Actions

	@IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
		// Hide the keyboard.
		nameTextField.resignFirstResponder()

		// UIImagePickerController is a view controller that lets a user pick media from their photo library
		let imagePickerController = UIImagePickerController()

		// Only allow photos to be picked, not taken
		imagePickerController.sourceType = .PhotoLibrary

		// Make sure ViewController is notified when the user picks an image.
		imagePickerController.delegate = self

		presentViewController(imagePickerController, animated: true, completion: nil)
	}
}
