//
//  SKPysicsBody+Extension.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/11/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
	typealias BodyBuilderClosure = (SKPhysicsBody) -> Void

	class func rectSize(size: CGSize, builderClosure: BodyBuilderClosure) -> SKPhysicsBody {
		let body = SKPhysicsBody(rectangleOfSize: size)
		builderClosure(body)

		return body
	}
}
