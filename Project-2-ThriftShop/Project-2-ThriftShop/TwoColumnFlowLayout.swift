//
//  TwoColumnFlowLayout.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class TwoColumnFlowLayout: UICollectionViewFlowLayout {
    
    private struct Constants {
        static let NumberColumns = CGFloat(2.0)
        static let InteritemSpacing = CGFloat(1.0)
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        configureItemSpacing()
        configureItemSize()
    }
}

// MARK Cell Layout

extension TwoColumnFlowLayout {
    func configureItemSpacing()  {
        minimumInteritemSpacing = Constants.InteritemSpacing
        minimumLineSpacing = Constants.InteritemSpacing
    }
    
    func configureItemSize() {
        let itemSide = (collectionViewContentSize().width / Constants.NumberColumns) - (Constants.InteritemSpacing * 0.5)
        itemSize = CGSizeMake(itemSide, itemSide)
    }
}
