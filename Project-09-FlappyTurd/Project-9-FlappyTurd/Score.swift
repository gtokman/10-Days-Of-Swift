//
//  Score.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/12/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import SpriteKit

class Score {
	private let score = SKLabelNode(text: "0")
	var currentScore = 0

	func addTo(parentNode: SKSpriteNode) -> Score {
		score.fontName = "MarkerFelt-Wide"
		score.fontSize = 30
		score.position = CGPoint(x: parentNode.size.width / 2, y: parentNode.size.height - 40)
		parentNode.addChild(score)
		return self
	}

	func increase() {
		currentScore += 1
		score.text = "\(currentScore)"
	}
}
