//
//  EcommerceViewController.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import SDWebImage

class EcommerceViewController: UICollectionViewController {
    
    // MARK: Constants
    
    let productStore = ProductStore(gateway: LocalProductGateway())
    private var products: [Product] = []
    
    // MARK: Init View Controller
    
    static func instantiate() -> UIViewController {
        return UIStoryboard(name: "Ecommerce", bundle: nil).instantiateInitialViewController()!
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Thrift Shop"
        
        productStore.retrieve { [weak self] products in
            self?.products = products
            self?.collectionView?.reloadData()
        }
    }
}

// MARK: Collection View

extension EcommerceViewController {
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCollectionViewCell
        
        let product = products[indexPath.row]
        
        cell.modelLabel?.text = product.name
        cell.descriptionLabel?.text = product.description
        cell.imageView?.sd_setImageWithURL(product.imageURL)
        cell.priceLabel?.text = "$\(product.price)"
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
        
    }
    
}
