//
//  ViewController.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - Properties

	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageIndicator: UIPageControl!

	override func viewDidLoad() {
		super.viewDidLoad()

		pageIndicator.numberOfPages = 0
	}

	// MARK: - Actions

	@IBAction func searchForMusicButton(sender: UIButton) {
		// Hide keyboard
		searchTextField.resignFirstResponder()

		// Search music
		ItunesConnection.getAlbumForString("Harry Potter") { album in

			// Custom view
			let musicView = NSBundle.mainBundle().loadNibNamed("MusicView", owner: self, options: nil).last as! MusicView

			musicView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
			musicView.updateConstraints()

			dispatch_async(dispatch_get_main_queue()) {
				musicView.addDataToMusicView(album)
				self.scrollView.addSubview(musicView)
			}
		}
	}
}
