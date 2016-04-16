//
//  Album.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class Album: NSObject {

    // Properties
    var title: String!
    var artist: String!
    var genre: String!
    var artworkURL: String!
    
    // Initialize
    init(title: String, artist: String, genre: String, artworkURL: String) {
        self.title = title
        self.artist = artist
        self.genre = genre
        self.artworkURL = artworkURL
    }
    
}
