//
//  UserStore.swift
//  Project-2-ThriftShop
//
//  Created by g tokman on 3/30/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

typealias Email = String

class UserStore {
    private struct Constants {
        static let emailKey = "emailKey"
    }
    
    func setUserEmail(email: Email) {
        print(email)
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: Constants.emailKey)
    }
    
    func userEmail() -> Email? {
        return NSUserDefaults.standardUserDefaults().objectForKey(Constants.emailKey) as? Email
    }
    
    func isUserSignedIn() -> Bool {
        return userEmail() != nil
    }
}