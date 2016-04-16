//
//  ItunesConnection.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ItunesConnection: NSObject {

	class func getAlbumForString(searchString: String) {

		// Url
		let url = NSURL(string: "https://itunes.apple.com/search?term=frozen&media=music")

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
		}
		task.resume()
	}
}
