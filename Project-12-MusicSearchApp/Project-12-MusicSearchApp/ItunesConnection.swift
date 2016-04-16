//
//  ItunesConnection.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItunesConnection: NSObject {

	typealias iTunesAlbumData = Album -> Void

	class func getAlbumForString(searchString: String, completionHandler: iTunesAlbumData) {

		let escapedString = searchString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())

		// Url
		let url = NSURL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")

		// Create task
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { data, response, error in

			guard error == nil else {
				print("Error getting iTunes data: \(error)")
				return
			}

			/* GUARD: Did we get a successful 2XX response? */
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
				print(error)
				return
			}

			/* GUARD: Was there any data returned? */
			guard let data = data else {
				return
			}

			// Deserialize Json
			let json = JSON(data: data)

			/* GUARD: Is "results" in the call */
			guard let resultsArray = json["results"].array else {
				print("nothing")
				return
			}

			print(resultsArray)

			let artist = resultsArray[0]["artistName"].stringValue
			let artworkURL = resultsArray[0]["artworkUrl100"].stringValue
			let albumtitle = resultsArray[0]["collectionName"].stringValue
			let genre = resultsArray[0]["primaryGenreName"].stringValue

			// Load model
			let album = Album(title: albumtitle, artist: artist, genre: genre, artworkURL: artworkURL)

			// Call completion handler
			completionHandler(album)
		}
		task.resume()
	}
}
