//
//  WeatherDayForecastView.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Cartography
import WeatherIconsKit

class WeatherDayForecastView: UIView {
    // UI Elements
    private var didSetupConstraints = false
    private let iconLabel = UILabel()
    private let dayLabel = UILabel()
    private let tempsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

private extension WeatherDayForecastView {
    func setup() {
        addSubview(iconLabel)
        addSubview(dayLabel)
        addSubview(tempsLabel)
    }
}

// MARK: Layout

extension WeatherDayForecastView {
    func layoutView() {
        constrain(self) {
            $0.height == 50
        }
        
        constrain(iconLabel) {
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left + 20
            $0.width == $0.height
            $0.height == 50
        }
        
        constrain(dayLabel, iconLabel) {
            $0.centerY == $0.superview!.centerY
            $0.left == $1.right + 20
        }
        
        constrain(tempsLabel) {
            $0.centerY == $0.superview!.centerY
            $0.right == $0.superview!.right - 20
        }
    }
}

// MARK: Style

private extension WeatherDayForecastView{
    func style(){
        iconLabel.textColor = UIColor.whiteColor()
        dayLabel.font = UIFont.latoFontOfSize(20)
        dayLabel.textColor = UIColor.whiteColor()
        tempsLabel.font = UIFont.latoFontOfSize(20)
        tempsLabel.textColor = UIColor.whiteColor()
    }
}

// MARK: Render

extension WeatherDayForecastView {
    func render(weatherCondition: WeatherCondition) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.stringFromDate(weatherCondition.time)
        iconLabel.attributedText = iconStringFromIcon(weatherCondition.icon!, size: 30)
        
        var usesMetric = false
        
        if let localeSystem =  NSLocale.currentLocale().objectForKey(NSLocaleUsesMetricSystem) as? Bool {
           usesMetric = localeSystem
        }
        
        if usesMetric {
           tempsLabel.text = "\(weatherCondition.minTempCelsius.roundToInt())º      \(weatherCondition.maxTempCelsius.roundToInt())º"
        } else {
            tempsLabel.text = "\(weatherCondition.minTempFahrenheit.roundToInt())º  \(weatherCondition.maxTempFahrenheit.roundToInt())º"
        }
        
    }
}
