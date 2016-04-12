//
//  Pipes.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import SpriteKit

class Pipes {
	// Properties
	private class var createActionKey: String { get { return "createActionKey" } }
	private var parentNode: SKSpriteNode!
	private let topPipeTexture: String
	private let bottomPipeTexture: String

	// Init
	init(topPipeTexture: String, bottomPipeTexture: String) {
		self.topPipeTexture = topPipeTexture
		self.bottomPipeTexture = bottomPipeTexture
	}

	// Methods
	func addTo(parentNode: SKSpriteNode) -> Pipes {
		self.parentNode = parentNode

		return self
	}
}

// MARK: - Startable

extension Pipes: Startable {
	func start() {
		let createAction = SKAction.repeatActionForever(SKAction.sequence([

			SKAction.runBlock {
				self.createNewPipesNode()
			},
			SKAction.waitForDuration(3)
			]))
		parentNode.runAction(createAction, withKey: Pipes.createActionKey)
	}

	func stop() {
		parentNode.removeActionForKey(Pipes.createActionKey)

		let pipesNodes = parentNode.children.filter {
			$0.name == PipesNode.kind
		}

		for pipe in pipesNodes {
			pipe.removeAllActions()
		}
	}
}

// MARK: - Private

private extension Pipes {
	func createNewPipesNode() {
		PipesNode(topPipeTexture: topPipeTexture, bottomPipeTexture: bottomPipeTexture, centerY: centerPipes()).addTo(parentNode).start()
	}

	func createPipes() -> CGFloat {
		return parentNode.size.height / 2 - 100 + 20 * CGFloat(arc4random_uniform(10))
	}
}
