//
//  CartGateWay.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

protocol CartGateWay {
    func addProductID(productID: String)
    func removeProductID(productID: String)
    func buy()
}