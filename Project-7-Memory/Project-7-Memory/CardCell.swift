//
//  CardCellCollectionViewCell.swift
//  Project-7-Memory
//
//  Created by g tokman on 4/5/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    private let frontImageView: UIImageView!
    private var cardImageName: String!
    private var backImageName: String!
    
    override init(frame: CGRect) {
        frontImageView = UIImageView(frame: CGRect(origin: CGPointZero, size: frame.size))
        super.init(frame: frame)
        contentView.addSubview(frontImageView)
        contentView.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderCardName(cardImageName: String, backImageName: String) {
        self.cardImageName = cardImageName
        self.backImageName = backImageName
        frontImageView.image = UIImage(named: self.backImageName)
    }
    
    func upturn() {
        UIView.transitionWithView(contentView, duration: 1, options: .TransitionFlipFromRight, animations: {
            self.frontImageView.image = UIImage(named: self.cardImageName)
            }, completion: nil)
    }
    
    func downturn() {
        UIView.transitionWithView(contentView, duration: 1, options: .TransitionFlipFromLeft, animations: {
            self.frontImageView.image = UIImage(named: self.backImageName)
            }, completion: nil)
    }
}

extension UIViewController {
    func execAfter(delay: Double, block: ()-> Void) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), block)
    }
}