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
        let pipeTopPosition = CGPoint(x: 0, y: centerY + pipeTop.size.height/2 + gapSize)
        pipeTop.position = pipeTopPosition
        pipesNode.addChild(pipeTop)
        
        
        
	}
}
