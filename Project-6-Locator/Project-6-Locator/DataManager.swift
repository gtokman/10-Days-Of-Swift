//
//  DataManager.swift
//  Project-6-Locator
//
//  Created by g tokman on 4/3/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import CoreLocation

class DataManager {
    static let sharedInstance = DataManager()
    
    var locations: [CLLocation]
    
    private init() {
        locations = [CLLocation]()
    }
}

