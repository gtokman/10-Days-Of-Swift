//
//  CGSize+Extension.swift
//  Project-9-FlappyTurd
//
//  Created by g tokman on 4/12/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import SpriteKit

extension CGSize {
	func scale(factor: CGFloat) -> CGSize {
		return CGSize(width: self.width * factor, height: self.height * factor)
	}
}
