//
//  ProductGateway.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

protocol ProductGateway {
    func getProducts(completion: (String) -> Void)
}