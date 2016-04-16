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

        // Create task
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { data, response, error in

			var iTunesDict: [String: AnyObject]!

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

			do {
				iTunesDict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject]
			} catch {
				print("Failed to serialize JSON: \(error)")
			}

			/* GUARD: Is "results" in the call */
			guard let resultsArray = iTunesDict["results"] as? [[String: AnyObject]] else {
				print("nothing")
				return
			}

			/*GUARD: First result has a value */
			guard let firstResult = resultsArray.first! as [String: AnyObject]? else {
				return
			}

			let artist = firstResult["artistName"] as! String
			let artworkURL = firstResult["artworkUrl100"] as! String
			let albumtitle = firstResult["collectionName"] as! String
			let genre = firstResult["primaryGenreName"] as! String

			// Load model
			let album = Album(title: albumtitle, artist: artist, genre: genre, artworkURL: artworkURL)

			// Call completion handler
			completionHandler(album)
		}
		task.resume()
	}
}
