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

    override func viewDidLoad() {
        super.viewDidLoad()
       
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }

   // MARK: Actions
    
    @IBAction func choosePhotoButton(sender: UIButton) {
        setupCamera()
    }
    
    @IBAction func takePhotoButton(sender: UIButton) {
    }


}

extension InitialViewController: UIImagePickerControllerDelegate {
    
    func setupCamera() {
        // Crashes if you switch the order
        imagePicker.sourceType = .Camera
        imagePicker.cameraDevice = .Front
        
        imagePicker.cameraCaptureMode = .Photo
        imagePicker.videoQuality = .TypeMedium
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func setupPicker() {
        
    }
    
}

extension InitialViewController: UINavigationControllerDelegate {
    
}