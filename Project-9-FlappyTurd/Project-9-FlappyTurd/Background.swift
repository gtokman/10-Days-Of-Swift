//
//  Background.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import SpriteKit

class Background {
    private let parallaxNode: ParallaxNode
    private let duration: Double
    
    init(textureNamed textureName: String, duration: Double) {
        parallaxNode = ParallaxNode(textureNamed: textureName)
        self.duration = duration
    }
    
    func addTo(parentNode: SKSpriteNode, zPosition: CGFloat) -> Self {
        parallaxNode.addTo(parentNode, zPosition: zPosition)
        
        return self
    }
}

// MARK: - Startable

extension Background: Startable {
    func start() {
        parallaxNode.start(duration: duration)
    }
    
    func stop() {
        parallaxNode.stop()
    }
}
