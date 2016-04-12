//
//  Bird.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import SpriteKit

class Bird: Startable {

	// Properties
	private var node: SKSpriteNode!
	private let textureNames: [String]

	var position: CGPoint {
		set { node.position = newValue }
		get { return node.position }
	}

	init(textureNames: [String]) {
		self.textureNames = textureNames
		node = createNode()
	}

	func addTo(scene: SKSpriteNode) -> Bird {
		scene.addChild(node)

		return self
	}
}

// MARK: - Creators

private extension Bird {
	func createNode() -> SKSpriteNode {
		let birdNode = SKSpriteNode(imageNamed: textureNames.first!)
		birdNode.zPosition = 2.0

		birdNode.physicsBody = SKPhysicsBody.rectSize(birdNode.size) {
			$0.dynamic = true
		}

		return birdNode
	}
}

// MARK: - Sartable

extension Bird {
	func start() {
		animate()
	}

	func stop() {
		node.physicsBody!.dynamic = false
		node.removeAllActions()
	}
}

// MARK: - Private

extension Bird {
	private func animate() {
		let animationFrames = textureNames.map { texName in
			SKTexture(imageNamed: texName)
		}

		node.runAction(SKAction.repeatActionForever(
			SKAction.animateWithTextures(animationFrames, timePerFrame: 0.5)
		))
	}
}

// MARK: - Actions

extension Bird {

	func flap() {
		node.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
		node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 8))
	}

	func update() {
		switch node.physicsBody!.velocity.dy {
		case let dy where dy > 30.0:
			node.zRotation = (3.14 / 6.0)
		case let dy where dy < -100.0:
			node.zRotation = -1 * (3.14 / 4.0)
		default:
			node.zRotation = 0.0
		}
	}
}