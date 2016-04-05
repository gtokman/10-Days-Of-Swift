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
        <#function body#>
    }
}
