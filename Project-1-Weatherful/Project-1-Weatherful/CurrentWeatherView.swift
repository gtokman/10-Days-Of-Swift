//
//  CurrentWeatherView.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Cartography

class CurrentWeatherView: UIView {
    
    static var HEIGHT: CGFloat { get { return 160 } }
    private var didSetupConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if didSetupConstraints {
            super.updateConstraints()
            return
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }
    
}

// MARK: Setup
private extension CurrentWeatherView{
    func setup(){
    }
}

// MARK: Layout
private extension CurrentWeatherView{
    func layoutView(){
        constrain(self) {
            $0.height == CurrentWeatherView.HEIGHT
        }
    }
}

// MARK: Style
private extension CurrentWeatherView{
    func style(){
        backgroundColor = UIColor.redColor()
    }
}