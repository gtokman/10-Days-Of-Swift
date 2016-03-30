//
//  RegisterViewController.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    static func instantiate() -> RegisterViewController {
        return UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as! RegisterViewController
    }

}
