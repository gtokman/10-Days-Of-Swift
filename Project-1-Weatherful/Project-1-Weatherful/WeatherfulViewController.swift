//
//  WeatherfulViewController.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Cartography


class WeatherfulViewController: UIViewController {
    
    // MARK: Properties
    
    static var INSET: CGFloat { get { return 20 } }
    
    // MARK: UI Elements
    
    private let backgroundView = UIImageView()
    private let scrollView = UIScrollView()
    private let currentWeatherView = CurrentWeatherView(frame: CGRectZero)
    private let hourlyForecastView = WeatherHourlyForecastView(frame: CGRectZero)
    private let daysForecastView = WeatherDaysForecastView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layoutView()
        style()
        render(UIImage(named: "loading"))
        
    }
}

// MARK: Setup

private extension WeatherfulViewController {
    
    func setup() {
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(daysForecastView)
        
        view.addSubview(backgroundView)
        view.addSubview(scrollView)
    }
}

// MARK: Layout

extension WeatherfulViewController {
    
    func layoutView() {
        constrain(backgroundView) {
            $0.edges == $0.superview!.edges
        }
        
        constrain(scrollView) {
            $0.edges == $0.superview!.edges
        }
        
        constrain(currentWeatherView) {
            $0.width == $0.superview!.width
            $0.centerX == $0.superview!.centerX
        }
        
        constrain(hourlyForecastView, currentWeatherView) {
            $0.top == $1.bottom + WeatherfulViewController.INSET
            $0.width == $0.superview!.width
            $0.centerX == $0.superview!.centerX
        }
        
        constrain(daysForecastView, hourlyForecastView) {
            $0.top == $1.bottom
            $0.width == $1.width
            $0.bottom == $0.superview!.bottom - WeatherfulViewController.INSET
            $0.centerX == $0.superview!.centerX
        }
        
        let currentWeatherInsect: CGFloat = view.frame.height - CurrentWeatherView.HEIGHT - WeatherfulViewController.INSET
        
        constrain(currentWeatherView) {
            $0.top == $0.superview!.top + currentWeatherInsect
        }
    }
    
}

// MARK: Style
private extension WeatherfulViewController {
    func style() {
        
    }
}

// MARK: Render
private extension WeatherfulViewController {
    func render(image: UIImage?) {
        if let image = image {
            backgroundView.image = image
        }
    }
}


