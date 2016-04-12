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

		let gapNode = createGap(size: CGSize(width: pipeBottom.size.width, height: gapSize * 2))
		gapNode.position = CGPoint(x: 0, y: centerY)
		pipesNode.addChild(gapNode)

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
	let size = CGSize(width: pipeNode.size.width, height: pipeNode.size.height)
	pipeNode.physicsBody = SKPhysicsBody.rectSize(size, builderClosure: { (body) in
		body.dynamic = false
		body.affectedByGravity = false
		body.categoryBitMask = BodyType.pipe.rawValue
		body.collisionBitMask = BodyType.pipe.rawValue
	})

	return pipeNode
}

// MARK: - Gap

private func createGap(size size: CGSize) -> SKSpriteNode {
	let gapNode = SKSpriteNode(color: .clearColor(), size: size)
	gapNode.zPosition = 6
	gapNode.physicsBody = SKPhysicsBody.rectSize(size, builderClosure: { (body) in
		body.dynamic = false
		body.affectedByGravity = false
		body.categoryBitMask = BodyType.gap.rawValue
		body.collisionBitMask = BodyType.gap.rawValue
	})

	return gapNode
}
