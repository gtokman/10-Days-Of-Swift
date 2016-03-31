//
//  EditPictuteViewController.swift
//  Project-3-PhotoShare
//
//  Created by g tokman on 3/31/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Social

class EditPictuteViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var boardView: BoardView!
    var currentElement: BoardView.Element?
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Actions
    
    @IBAction func addCircle(sender: UIButton) {
        currentElement = BoardView.Elementcircle()
        boardView.addElement(currentElement!)
    }
    
    @IBAction func addHat(sender: UIButton) {
        if let image = UIImage(named: "hat") {
            currentElement = BoardView.ElementPicture(image: image)
            boardView.addElement(currentElement!)
        }
    }
    
    @IBAction func addText(sender: UIButton) {
        setupAddText()
    }
    
    
    @IBAction func facebookButton(sender: UIButton) {
        setupFacebook()
    }
    
}

// MARK: Setup

extension EditPictuteViewController {
    func setup() {
        let element = BoardView.ElementBackground(image: UIImage(CGImage: photo.CGImage!, scale: 2, orientation: photo.imageOrientation))
        boardView.addElement(element)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(EditPictuteViewController.dragging(_:)))
        boardView.addGestureRecognizer(gesture)
    }
    
    func dragging(gesture: UIPanGestureRecognizer) {
        if let currentElement = self.currentElement {
            currentElement.position = gesture.locationInView(self.boardView)
            
            if gesture.state == .Ended {
                self.currentElement = nil
            }
        }
    }
    
    func setupAddText() {
        let alertController = UIAlertController(title: "Text", message: "Say something!", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Say something :)"
        }
        
        let action = UIAlertAction(title: "OK", style: .Default) { (action) in
            let text = alertController.textFields?.first?.text
            let textFontAttributes: [String: AnyObject] = [
                
                NSFontAttributeName: UIFont(name: "Helvetica", size: CGFloat(24.0))!,
                NSForegroundColorAttributeName : UIColor.redColor(),
                NSParagraphStyleAttributeName: NSMutableParagraphStyle.defaultParagraphStyle()
            ]
            self.currentElement = BoardView.ElementText(text: text!, attributes: textFontAttributes)
            self.boardView.addElement(self.currentElement!)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in
            print("Canceled text!")
        }
        
        alertController.addAction(action)
        alertController.addAction(cancel)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func setupFacebook() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let fbViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbViewController.addImage(boardView.getImage())
            
            fbViewController.completionHandler = { result in
                
                switch result {
                case .Cancelled:
                    print("Canceled FB post!")
                case .Done:
                    print("Posted to FB!")
                    self.performSegueWithIdentifier("Restart", sender: self)
                }
            }
            presentViewController(fbViewController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Log in", message: "You must login in to post photos on Facebook!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Cancel, handler: { (_) in
                print("Canceled")
            })
            
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}


















