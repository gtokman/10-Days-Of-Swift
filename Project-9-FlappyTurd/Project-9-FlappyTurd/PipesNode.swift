//
//  PipesNode.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import SpriteKit

class PipesNode {
	// Properties
	class var kind: String { get { return "PIPES" } }
	private let gapSize: CGFloat = 50

	private let pipesNode: SKNode
	private let finalOffset: CGFloat!
	private let startingOffset: CGFloat!

	// Init
	init(topPipeTexture: String, bottomPipeTexture: String, centerY: CGFloat) {
		pipesNode = SKNode()
		pipesNode.name = PipesNode.kind

		let pipeTop = createPipe(imageNamed: topPipeTexture)
		let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height / 2 + gapSize)
		pipeTop.position = pipeTopPosition
		pipesNode.addChild(pipeTop)

		let pipeBottom = createPipe(imageNamed: bottomPipeTexture)
		let pipeBottonPosition = CGPoint(x: 0, y: centerY - pipeBottom.size.height / 2 - gapSize)
		pipeBottom.position = pipeBottonPosition
		pipesNode.addChild(pipeBottom)

		finalOffset = -pipeBottom.size.width
		startingOffset = -finalOffset
	}

	// Methods
	func addTo(parentNode: SKSpriteNode) -> PipesNode {
		let pipePostion = CGPoint(x: parentNode.size.width + startingOffset, y: 0)
		pipesNode.position = pipePostion
		pipesNode.zPosition = 4

		parentNode.addChild(pipesNode)

		return self
	}

	func start() {
		pipesNode.runAction(SKAction.sequence(
			[
				SKAction.moveToX(finalOffset, duration: 6.0),
				SKAction.removeFromParent()
			]))
	}
}

// MARK: - Creators
private func createPipe(imageNamed imageNamed: String) -> SKSpriteNode {
	let pipeNode = SKSpriteNode(imageNamed: imageNamed)

	return pipeNode
}