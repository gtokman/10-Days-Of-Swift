//
//  EcommerceViewController.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class EcommerceViewController: UIViewController {
    
    // MARK: Init View Controller
    
    static func instantiate() -> UIViewController {
        return UIStoryboard(name: "Ecommerce", bundle: nil).instantiateInitialViewController()!
    }

}
