//
//  ViewController.swift
//  Project-12-MusicSearchApp
//
//  Created by g tokman on 4/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import MONActivityIndicatorView

class ViewController: UIViewController {

	// MARK: - Properties

	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var pageIndicator: UIPageControl!
	var numberOfItems = 0
	var activityIndicator: MONActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Add activity indicator
		activityIndicator = MONActivityIndicatorView()
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(activityIndicator)

		NSLayoutConstraint.activateConstraints([
			activityIndicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
			activityIndicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
		])

		pageIndicator.numberOfPages = 0
		scrollView.delegate = self
	}

	// MARK: - Actions

	@IBAction func searchForMusicButton(sender: UIButton) {
		// Activity indicator
		activityIndicator.center = self.view.center
		activityIndicator.startAnimating()

		// Hide keyboard
		searchTextField.resignFirstResponder()
		searchTextField.clearsOnBeginEditing = true

		// Check textfield has a value
		guard let textfield = searchTextField.text where !textfield.isEmpty else {
			print("textfield is empty 😕")
			return
		}

		// Search music
		ItunesConnection.getAlbumForString(textfield) { album in

			self.numberOfItems += 1

			self.scrollView.contentSize = CGSizeMake(CGFloat(self.numberOfItems) * self.scrollView.frame.width, self.scrollView.frame.height)

			// Custom view
			let musicView = NSBundle.mainBundle().loadNibNamed("MusicView", owner: self, options: nil).last as! MusicView

			musicView.frame = CGRectMake(CGFloat(self.numberOfItems - 1) * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
			musicView.updateConstraints()

			dispatch_async(dispatch_get_main_queue()) {
				self.activityIndicator.stopAnimating()
				musicView.addDataToMusicView(album)
				self.pageIndicator.numberOfPages = self.numberOfItems
				self.scrollView.addSubview(musicView)
				self.scrollView.scrollRectToVisible(musicView.frame, animated: true)
			}
		}
	}
}

extension ViewController: UIScrollViewDelegate {

	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
		pageIndicator.currentPage = page
	}
}