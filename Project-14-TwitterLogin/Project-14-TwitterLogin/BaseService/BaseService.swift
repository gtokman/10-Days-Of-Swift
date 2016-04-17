//
//  BaseService.swift
//  Project-14-TwitterLogin
//
//  Created by g tokman on 4/17/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Firebase

let baseURL = "https://project-twitterlogin.firebaseio.com"
let twitterAPIKey = "nEplC1YXFwh8RKbAtHpKwbL8z"
let firebaseRef = Firebase(url: baseURL)
let twitterAuthHelper = TwitterAuthHelper(firebaseRef: firebaseRef, apiKey: twitterAPIKey)
var currentUser: Firebase {
    // Save user ID
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    // Add to Firebase "users" child
    let currentUser = firebaseRef.childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser
}






