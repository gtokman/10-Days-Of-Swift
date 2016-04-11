//
//  GameScene.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright (c) 2016 garytokman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
   
    private var screenNode: SKSpriteNode!
    private var actors: [Startable]!
    
    override func didMoveToView(view: SKView) {
        screenNode = SKSpriteNode(color: .clearColor(), size: self.size)
        screenNode.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(screenNode)
        
        let sky = Background(textureNamed: "sky", duration: 60.0).addTo(screenNode, zPosition: 0)
        let city = Background(textureNamed: "city", duration: 20.0).addTo(screenNode, zPosition: 1)
        let ground = Background(textureNamed: "ground", duration: 5.0).addTo(screenNode, zPosition: 2)
        actors = [sky, city, ground]
        
        for actor in actors {
            actor.start()
        }
    }
}
