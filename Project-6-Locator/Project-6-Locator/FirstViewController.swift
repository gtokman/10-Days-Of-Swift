//
//  FirstViewController.swift
//  Project-6-Locator
//
//  Created by g tokman on 4/3/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UITableViewController {
    
    // MARK: Properties
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()

    // MARK: Life Cycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        askLocationPermission()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    // MARK: Actions

    @IBAction func addLocationButton(sender: UIBarButtonItem) {
        
    }
}

extension FirstViewController {
    func askLocationPermission() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        switch (CLLocationManager.authorizationStatus()) {
       
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.stopUpdatingLocation()
        case .Denied:
            let alert = UIAlertController(title: "Permissions error", message: "This app needs location permission to find you!", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        case .NotDetermined:
            fallthrough
        default:
            locationManager.requestWhenInUseAuthorization()
    }
}