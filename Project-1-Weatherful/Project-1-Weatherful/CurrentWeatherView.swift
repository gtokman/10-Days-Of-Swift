//
//  CurrentWeatherView.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Cartography
import LatoFont
import WeatherIconsKit

class CurrentWeatherView: UIView {
    
    static var HEIGHT: CGFloat { get { return 160 } }
    private var didSetupConstraints = false
    
    // UI Elements
    private let cityLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let minTempLabel = UILabel()
    private let iconLabel = UILabel()
    private let weatherLabel = UILabel()
    private let currentTempLabel = UILabel()
    
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
        addSubview(cityLabel)
        addSubview(maxTempLabel)
        addSubview(minTempLabel)
        addSubview(iconLabel)
        addSubview(weatherLabel)
        addSubview(currentTempLabel)
    }
}

// MARK: Layout

private extension CurrentWeatherView{
    func layoutView(){
        constrain(self) {
            $0.height == CurrentWeatherView.HEIGHT
        }
        
        constrain(iconLabel) {
            $0.top == $0.superview!.top
            $0.left == $0.superview!.left + 20
            $0.width == 30
            $0.width == $0.height
        }
        
        constrain(weatherLabel, iconLabel) {
            $0.top == $1.top
            $0.left == $1.right + 10
            $0.height == $1.height
            $0.width == 200
        }
        
        constrain(currentTempLabel, iconLabel) {
            $0.top == $1.bottom
            $0.left == $1.left
        }
        
        constrain(currentTempLabel, minTempLabel) {
            $0.bottom == $1.top
            $0.left == $1.left
        }
        
        constrain(minTempLabel) {
            $0.bottom == $0.superview!.bottom
            $0.height == 30
        }
        
        constrain(maxTempLabel, minTempLabel) {
            $0.top == $1.top
            $0.height == $1.height
            $0.left == $1.right + 10
        }
        
        constrain(cityLabel) {
            $0.bottom == $0.superview!.bottom
            $0.right == $0.superview!.right - 10
            $0.height == 30
            $0.width == 200
        }
        
    }
}

// MARK: Style

private extension CurrentWeatherView{
    func style(){
        iconLabel.textColor = UIColor.whiteColor()
        
        weatherLabel.font = UIFont.latoLightFontOfSize(20)
        weatherLabel.textColor = UIColor.whiteColor()
        
        currentTempLabel.font = UIFont.latoLightFontOfSize(96)
        currentTempLabel.textColor = UIColor.whiteColor()
        
        maxTempLabel.font = UIFont.latoLightFontOfSize(18)
        maxTempLabel.textColor = UIColor.whiteColor()
        
        minTempLabel.font = UIFont.latoLightFontOfSize(18)
        minTempLabel.textColor = UIColor.whiteColor()
        
        cityLabel.font = UIFont.latoLightFontOfSize(18)
        cityLabel.textColor = UIColor.whiteColor()
        cityLabel.textAlignment = .Right
    }
}

// MARK: Render

extension CurrentWeatherView {
    func render() {
        iconLabel.attributedText = WIKFontIcon.wiDaySunnyIconWithSize(20).attributedString()
        weatherLabel.text = "Sunny"
        minTempLabel.text = "30º"
        maxTempLabel.text = "50º"
        currentTempLabel.text = "42º"
        cityLabel.text = "Orlando"
    }
}
















