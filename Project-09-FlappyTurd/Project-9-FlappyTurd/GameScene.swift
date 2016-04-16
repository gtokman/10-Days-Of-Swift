//
//  GameScene.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright (c) 2016 garytokman. All rights reserved.
//

import SpriteKit
import SIAlertView

enum BodyType: UInt32 {
	case bird = 1 // (1 << 0)
	case ground = 2 // (1 << 1)
	case pipe = 4 // (1 << 2)
	case gap = 8 // (1 << 3)
}

class GameScene: SKScene {

	private var screenNode: SKSpriteNode!
	private var bird: Bird!
	private var actors: [Startable]!
	private var score = Score()
	var onPlayAgainPressed: (() -> Void)!
	var onCancelPressed: (() -> Void)!

	override func didMoveToView(view: SKView) {
		physicsWorld.contactDelegate = self
		physicsWorld.gravity = CGVector(dx: 0, dy: 0)

		screenNode = SKSpriteNode(color: .clearColor(), size: self.size)
		screenNode.anchorPoint = CGPoint(x: 0, y: 0)
		addChild(screenNode)

		let sky = Background(textureNamed: "sky", duration: 60.0).addTo(screenNode, zPosition: 0)
		let city = Background(textureNamed: "city", duration: 20.0).addTo(screenNode, zPosition: 1)
		let ground = Background(textureNamed: "ground", duration: 5.0).addTo(screenNode, zPosition: 2)
		let pipes = Pipes(topPipeTexture: "topPipe.png", bottomPipeTexture: "bottomPipe").addTo(screenNode)
		score.addTo(screenNode)
		screenNode.addChild(bodyTextureName("ground"))
		ground.zPosition(5)

		bird = Bird(textureNames: ["bird1.png", "bird2.png"]).addTo(screenNode)
		bird.position = CGPointMake(30.0, 400.0)

		actors = [sky, city, ground, bird, pipes]

		for actor in actors {
			actor.start()
		}
	}

	override func update(currentTime: NSTimeInterval) {
		bird.update()
	}

	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		bird.flap()
		physicsWorld.gravity = CGVector(dx: 0, dy: -3)
	}
}

// MARK: - Contacts

extension GameScene: SKPhysicsContactDelegate {
	func didBeginContact(contact: SKPhysicsContact) {
		let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

		switch (contactMask) {
		case BodyType.pipe.rawValue | BodyType.bird.rawValue:
			print("Contact with pipe")
			bird.pushDown()
		case BodyType.ground.rawValue | BodyType.bird.rawValue:
			print("Contact with ground")
			for actor in actors {
				actor.stop()
			}
			askToPlayAgain()
		default:
			return
		}
	}

	func didEndContact(contact: SKPhysicsContact) {
		let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

		switch (contactMask) {
		case BodyType.gap.rawValue | BodyType.bird.rawValue:
			print("Contact with gap")
			score.increase()
		default:
			return
		}
	}
}

// MARK: - Ground collision

private extension GameScene {
	func bodyTextureName(textureName: String) -> SKNode {
		let image = UIImage(named: textureName)
		let width = image!.size.width
		let height = image!.size.height
		let groundBody = SKNode()
		groundBody.position = CGPoint(x: width / 2, y: height / 2)

		groundBody.physicsBody = SKPhysicsBody.rectSize(CGSize(width: width, height: height)) { (body) in
			body.dynamic = false
			body.affectedByGravity = false
			body.categoryBitMask = BodyType.ground.rawValue
			body.collisionBitMask = BodyType.ground.rawValue
		}

		return groundBody
	}
}

// MARK: - Private

private extension GameScene {
	func askToPlayAgain() {
		let alertView = SIAlertView(title: "Ouch!", andMessage: "Congrats! Your score is \(score.currentScore). Play again?")

		alertView.addButtonWithTitle("OK", type: .Default) { (button) in
			self.onPlayAgainPressed()
		}
		alertView.addButtonWithTitle("Cancel", type: .Cancel) { (button) in
			self.onCancelPressed()
		}
		alertView.transitionStyle = .Bounce
		alertView.buttonColor = UIColor.ht_aquaColor()
		alertView.cancelButtonColor = UIColor.ht_grapeFruitColor()
		alertView.show()
	}
}