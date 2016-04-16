//
//  LocalProductGateway.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

class LocalProductGateway: ProductGateway {
    func getProducts(completion: (String) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("products", ofType: "json")
        
        do {
            completion(try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding))
        } catch {
            completion("[:]")
        }
        
    }
}