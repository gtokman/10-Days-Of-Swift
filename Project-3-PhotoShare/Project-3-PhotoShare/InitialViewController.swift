//
//  ViewController.swift
//  Project-3-PhotoShare
//
//  Created by g tokman on 3/31/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: Properties
    
    var imagePicker = UIImagePickerController()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    // MARK: Actions
    
    @IBAction func choosePhotoButton(sender: UIButton) {
        setupPicker()
    }
    
    @IBAction func takePhotoButton(sender: UIButton) {
        setupCamera()
    }
    
    
}

// MARK: Setup

extension InitialViewController {
    
    func setupCamera() {
        // Crashes if you switch the order
        imagePicker.sourceType = .Camera
        imagePicker.cameraDevice = .Front
        
        imagePicker.cameraCaptureMode = .Photo
        imagePicker.videoQuality = .TypeMedium
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func setupPicker() {
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: Image Picker  Controller Delegate

extension InitialViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let editPictureViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditPhoto") as! EditPictureViewController
            editPictureViewController.photo = image
            self.presentViewController(editPictureViewController, animated: true, completion: nil)
        }
    }
    
    // Cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true) {
            print("User cancel taking photo")
        }
    }
}

// MARK: Navigation Controller Delegate

extension InitialViewController: UINavigationControllerDelegate {
    
}

// MARK: Unwind
extension InitialViewController {
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
    }
}









