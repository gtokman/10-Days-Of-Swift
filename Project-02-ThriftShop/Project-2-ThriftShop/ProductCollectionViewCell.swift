//
//  ProductCollectionViewCell.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet var modelLabel: UILabel? {
        didSet {
            modelLabel?.font = UIFont.latoFontOfSize(18)
        }
    }
    
    @IBOutlet var imageView: UIImageView?
    
    @IBOutlet var descriptionLabel: UILabel? {
        didSet {
            descriptionLabel?.font = UIFont.latoFontOfSize(18)
        }
    }
    
    @IBOutlet var priceLabel: UILabel? {
        didSet {
            priceLabel?.font = UIFont.latoBoldFontOfSize(18)
        }
    }
    
}
