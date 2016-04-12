//
// Created by g tokman on 4/11/16.
// Copyright (c) 2016 garytokman. All rights reserved.
//

import Foundation
import SpriteKit

class ParallaxNode {
    // Properties
    private  let node: SKSpriteNode!
    
    // Init
    init(textureNamed: String) {
        let leftHalf = createHalfNodeTexture(textureNamed, offsetX: 0)
        let rightHalf = createHalfNodeTexture(textureNamed, offsetX: leftHalf.size.width)
        
        let size = CGSize(width: leftHalf.size.width + rightHalf.size.width, height: leftHalf.size.height)
        
        node = SKSpriteNode(color: .clearColor(), size: size)
        node.anchorPoint = CGPointZero
        node.position = CGPointZero
        node.addChild(leftHalf)
        node.addChild(rightHalf)
    }
    
    // Methods
    func zPosition(zPosition: CGFloat) -> ParallaxNode {
        node.zPosition = zPosition
        return self
    }
    
    func addTo(parentNode: SKSpriteNode, zPosition: CGFloat) -> ParallaxNode {
        parentNode.addChild(node)
        node.zPosition = zPosition
        
        return self
    }
}

// MARK: - Private

private func createHalfNodeTexture(textureNamed: String, offsetX: CGFloat) -> SKSpriteNode {
    let node = SKSpriteNode(imageNamed: textureNamed, normalMapped: true)
    node.anchorPoint = CGPointZero
    node.position = CGPoint(x: offsetX, y: 0)
    
    return node
}

// MARK: - Startable

extension ParallaxNode {
    func start(duration duration: NSTimeInterval) {
        node.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveToX(-node.size.width/2.0, duration: duration),
            SKAction.moveToX(0, duration: 0)
            ])))
    }
    
    func stop() {
        node.removeAllActions()
    }
}