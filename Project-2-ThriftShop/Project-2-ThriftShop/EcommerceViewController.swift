//
//  EcommerceViewController.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import SDWebImage
import BBBadgeBarButtonItem
import FontAwesomeKit

class EcommerceViewController: UICollectionViewController {
    
    // MARK: Constants
    
    let productStore = ProductStore(gateway: LocalProductGateway())
    let cartStore = CartStore(gateway: LocalCartGateway())
    private var products: [Product] = []
    
    
    
    // MARK: Init View Controller
    
    static func instantiate() -> UIViewController {
        return UIStoryboard(name: "Ecommerce", bundle: nil).instantiateInitialViewController()!
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Thrift Shop"
        setupCart()
        
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
        
        if cartStore.containsProductID(product.id) {
            cell.backgroundColor = UIColor.lightGrayColor()
        } else {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let product = products[indexPath.row]
        
        if cartStore.containsProductID(product.id) {
            cartStore.removeProduct(product)
        } else {
            cartStore.addProduct(product)
        }
        
        refreshCartCount()
        collectionView.reloadData()
    }
    
}

extension EcommerceViewController {
    
    func setupCart() {
        let button = UIButton(type: .Custom)
        let icon = FAKFontAwesome.shoppingCartIconWithSize(20)
        button.setAttributedTitle(icon.attributedString(), forState: .Normal)
        button.addTarget(self, action: #selector(EcommerceViewController.cartButtonTapped(_:)), forControlEvents: .TouchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        let cartBarButton = BBBadgeBarButtonItem(customUIButton: button)
        cartBarButton.badgeOriginX = 0
        cartBarButton.badgeOriginY = 0
        navigationItem.rightBarButtonItem = cartBarButton
    }
    
    func cartButtonTapped(sender: UIButton) {
        print("showCheckoutScene()")
    }
    
    func refreshCartCount() {
        guard let cartBarButton = navigationItem.rightBarButtonItem as? BBBadgeBarButtonItem else {
            return
        }
        
        cartBarButton.badgeValue = "\(cartStore.count())"
    }
    
}






















