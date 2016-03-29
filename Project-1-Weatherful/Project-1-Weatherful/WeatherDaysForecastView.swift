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
    
    private var didSetupConstraints = false
    
    // UI Elements
    private var forecastCells = [WeatherDayForecastView]()
    
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
        
        (0..<7).forEach { _ in
            let cell = WeatherDayForecastView(frame: CGRectZero)
            forecastCells.append(cell)
            addSubview(cell)
        }
        
    }
}

// MARK: Layout

private extension WeatherDaysForecastView{
    func layoutView(){
        constrain(forecastCells.first!) {
            $0.top == $0.superview!.top
        }
        
        for idx in 0..<(forecastCells.count - 1) {
            let cell = forecastCells[idx]
            let nextCell = forecastCells[idx+1]
            constrain(cell, nextCell) {
                $0.bottom == $1.top
            }
        }
        
        forecastCells.forEach { cell in
            constrain(cell) {
                $0.left == $0.superview!.left
                $0.right == $0.superview!.right
            }
        }
        
        constrain(forecastCells.last!) {
            $0.bottom == $0.superview!.bottom
        }
    }
}

// MARK: Style

private extension WeatherDaysForecastView{
    func style(){
       
    }
}

// MARK: Render

extension WeatherDaysForecastView {
    
    func render(weatherConditions:[WeatherCondition]) {
        zip(forecastCells, weatherConditions).forEach {
            $0.render($1)
        }
    }
    
}