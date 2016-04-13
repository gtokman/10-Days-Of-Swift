//
//  MealTableViewCell.swift
//  Project-10-FoodTracker
//
//  Created by g tokman on 4/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

	// MARK: - Properties

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingController!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}
}
