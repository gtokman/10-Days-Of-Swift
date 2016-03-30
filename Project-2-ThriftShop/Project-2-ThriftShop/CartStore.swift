//
//  CartStore.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

class CartStore {
    private var products = [String:Product]()
    private let gateway: CartGateWay
    
    init(gateway: CartGateWay) {
        self.gateway = gateway
    }
    
    func containsProductID(productID: String) -> Bool {
        return products[productID] != nil
    }
    
    func addProduct(product: Product) {
        products[product.id]  = product
        gateway.addProductID(product.id)
    }
    
    func removeProduct(product: Product) {
        products.removeValueForKey(product.id)
        gateway.removeProductID(product.id)
    }
    
    func buy() {
        products = [:]
        gateway.buy()
    }
    
    func count() -> Int {
        return products.count
    }
}
