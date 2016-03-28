//
//  WeatherDaysForecastView.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Cartography

class WeatherDaysForecastView: UIView {
    
    static var HEIGHT: CGFloat { get { return 300 } }
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
private extension WeatherDaysForecastView{
    func setup(){
    }
}

// MARK: Layout
private extension WeatherDaysForecastView{
    func layoutView(){
        constrain(self) {
            $0.height == WeatherDaysForecastView.HEIGHT
            return
        }
    }
}

// MARK: Style
private extension WeatherDaysForecastView{
    func style(){
        backgroundColor = UIColor.blueColor()
    }
}