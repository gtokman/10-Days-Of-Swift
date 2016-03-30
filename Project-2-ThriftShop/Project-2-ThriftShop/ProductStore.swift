//
//  ProductStore.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductStore {
    private struct ProductKeys {
        static let products = "products"
        static let ID = "id"
        static let name = "name"
        static let price = "price"
        static let description = "description"
        static let imageURL = "imageURL"
    }
    
    private let gateway: ProductGateway
    
    init(gateway: ProductGateway) {
        self.gateway = gateway
    }
    
    func retrieve(completion: ([Product] -> Void)) {
        gateway.getProducts { productsJSON in
            
            if let dataFromString = productsJSON.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)  {
                let json = JSON(data: dataFromString)
                
                let productsJSON = json[ProductKeys.products]
                
                let products = productsJSON.map { (index, product) in
                    
                    Product(id: product[ProductKeys.ID].stringValue, name: product[ProductKeys.name].stringValue, price: product[ProductKeys.price].doubleValue , description: product[ProductKeys.description].stringValue, imageURL: NSURL(string: product[ProductKeys.imageURL].stringValue)!)
                }
                completion(products)
            }
        }
    }
}
