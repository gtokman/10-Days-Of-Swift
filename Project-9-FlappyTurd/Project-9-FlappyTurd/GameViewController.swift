//
//  GameViewController.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright (c) 2016 garytokman. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

	private let skView = SKView()

	override func viewDidLoad() {
		super.viewDidLoad()

		skView.frame = view.bounds
		view.addSubview(skView)

		createTheScene()
	}

	private func createTheScene() {

		let scene = GameScene.unarchiveFromFile("GameScene")
		if let scene = scene as? GameScene {
			scene.size = skView.frame.size
			skView.showsFPS = true
			skView.showsNodeCount = true
			skView.ignoresSiblingOrder = true
			scene.scaleMode = .AspectFill

			scene.onPlayAgainPressed = { [weak self] in
				self?.createTheScene()
			}

			scene.onCancelPressed = { [weak self] in
				self?.dismissViewControllerAnimated(true, completion: nil)
			}
			skView.presentScene(scene)
		}
	}

	override func shouldAutorotate() -> Bool {
		return true
	}

	override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			return .AllButUpsideDown
		} else {
			return .All
		}
	}

	override func prefersStatusBarHidden() -> Bool {
		return true
	}
}

// MARK: - Convienece method

extension SKNode {
	class func unarchiveFromFile(file: NSString) -> SKNode? {
		if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
			let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
			let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)

			archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
			let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
			archiver.finishDecoding()
			return scene
		} else {
			return nil
		}
	}
}
