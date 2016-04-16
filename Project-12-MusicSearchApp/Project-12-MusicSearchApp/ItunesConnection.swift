//
//  ItunesConnection.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ItunesConnection: NSObject {

	typealias iTunesAlbumData = Album -> Void

	class func getAlbumForString(searchString: String, completionHandler: iTunesAlbumData) {

		let escapedString = searchString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())

		// Url
		let url = NSURL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")

		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { data, response, error in

			var iTunesDict: [String: AnyObject]

			guard error == nil else {
				print("Error getting iTunes data: \(error)")
				return
			}

			do {
				iTunesDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String: AnyObject]
				 print(iTunesDict)
			} catch {
				print("Failed to serialize JSON: \(error)")
			}

			// Load model
			let album = Album(title: "Frozen", artist: "Idina Menzel", genre: "Soundtrack", artworkURL: "")

			completionHandler(album)
		}
		task.resume()
	}
}
