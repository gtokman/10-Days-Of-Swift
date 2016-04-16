//
//  MusicView.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class MusicView: UIView {

	// MARK: - Properties

	@IBOutlet weak var artworkImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var artistLabel: UILabel!
	@IBOutlet weak var genreLabel: UILabel!

	func addDataToMusicView(album: Album) {

		// Convert artwork url to NSData
		guard let url = NSURL(string: album.artworkURL), let imageData = NSData(contentsOfURL: url) else {
			return
		}

		// Set UI
		artworkImageView.image = UIImage(data: imageData)
		titleLabel.text = album.title
		artistLabel.text = album.artist
		genreLabel.text = album.genre
	}
}
