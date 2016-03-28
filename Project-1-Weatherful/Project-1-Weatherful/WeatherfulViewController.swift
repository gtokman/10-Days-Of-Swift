//
//  WeatherfulViewController.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Cartography
import FXBlurView


class WeatherfulViewController: UIViewController {
    
    // MARK: Properties
    
    static var INSET: CGFloat { get { return 20 } }
    
    // MARK: UI Elements
    private let gradientView = UIView()
    private let overlayView = UIImageView()
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
        renderSubviews()
        
    }
}

// MARK: Setup

private extension WeatherfulViewController {
    
    func setup() {
        
        // Background image
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
        
        // Image Blur
        overlayView.contentMode = .ScaleAspectFill
        overlayView.clipsToBounds = true
        
        view.addSubview(overlayView)
        view.addSubview(gradientView)
        
        // Add Scroll view
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(daysForecastView)
        scrollView.delegate = self
        view.addSubview(scrollView)
    }
}

// MARK: Layout

extension WeatherfulViewController {
    
    func layoutView() {
        constrain(backgroundView) {
            $0.edges == $0.superview!.edges
        }
        
        constrain(overlayView) {
            $0.edges == $0.superview!.edges
        }
        
        constrain(scrollView) {
            $0.edges == $0.superview!.edges
        }
        
        constrain(gradientView) {
            $0.edges ==  $0.superview!.edges
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
        gradientView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        let blackColor = UIColor(white: 0, alpha: 0.0)
        let clearColor = UIColor(white: 0, alpha: 1.0)
        
        gradientLayer.colors = [blackColor.CGColor, clearColor.CGColor]
        
        gradientLayer.startPoint = CGPointMake(1.0, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 1.0)
        gradientView.layer.mask = gradientLayer
    }
}

// MARK: Render

private extension WeatherfulViewController {
    func render(image: UIImage?) {
        guard let image = image else { return }
        backgroundView.image = image
        overlayView.image = image.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        overlayView.alpha = 0
        
    }
    
    func renderSubviews() {
        currentWeatherView.render()
        hourlyForecastView.render()
        daysForecastView.render()
    }
}

// MARK: UIScrollViewDelegate

extension WeatherfulViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let treshold: CGFloat = CGFloat(view.frame.height)/2
        overlayView.alpha = min (1.0, offset/treshold)
    }
}

