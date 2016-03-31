//
//  BoardView.swift
//  Project-3-PhotoShare
//
//  Created by g tokman on 3/31/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class BoardView: UIView {
    // Stored Props
    private var elements = [Element]()
    
    // Methods
    func addElement(element: BoardView.Element) {
        element.view = self
        elements.append(element)
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for element in elements {
            element.draw()
        }
    }
    
    func getImage() -> UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        self.drawViewHierarchyInRect(self.frame, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // Nested Classes
    class Element {
        var position:CGPoint? {
            didSet{
                self.view?.setNeedsDisplay()
            }
        }
        
        var view:BoardView?
        
        func draw(){
            fatalError("The function \(#function) shouldn't be called from the base class")
        }
        
        
        
        class ElementBackground: BoardView.Element {
            var image: UIImage
            init(image: UIImage) {
                self.image = image
                super.init()
                self.position = CGPointZero
            }
            
            override func draw() {
                if let position = self.position {
                    image.drawAtPoint(position)
                }
            }
        }
        
        class ElementPicture: BoardView.Element {
            var image: UIImage
            
            init(image: UIImage) {
                self.image = image
                super.init()
            }
            
            override func draw() {
                if let position = self.position {
                    let newPosition = CGPointMake(position.x - image.size.width / 2, position.y - image.size.height / 2)
                    image.drawAtPoint(newPosition)
                }
            }
        }
        
        class ElementText: BoardView.Element {
            var text: String
            var attributes: [String: AnyObject]
            
            init(text: String, attributes: [String: AnyObject]) {
                self.text = text
                self.attributes = attributes
                super.init()
            }
            
            override func draw() {
                if let position = self.position {
                    text.drawAtPoint(position, withAttributes: attributes)
                }
            }
            
            class Elementcircle: BoardView.Element {
                var initialPoint: CGPoint?
                
                override var position: CGPoint? {
                    get {
                        return super.position
                    }
                    
                    set {
                        if initialPoint == nil {
                            initialPoint = newValue
                        }
                        super.position = newValue
                    }
                }
            }
            
        }
    }
}
