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
        addLocation()
    }
}

// MARK: Setup

extension FirstViewController {
    func askLocationPermission() {
//        locationManager.delegate = self
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
    
    func addLocation() {
        var location: CLLocation
        
        if (CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse) {
            location = CLLocation(latitude: 32.830579, longitude: -117.153839)
        } else {
            location = locationManager.location!
        }
        
        DataManager.sharedInstance.locations.insert(location, atIndex: 0)
        
        tableView.reloadData()
    }
}


// MARK: Table View Data Source

extension FirstViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationCell", forIndexPath: indexPath)
        
        cell.tag = indexPath.row
        
        let entry: CLLocation = DataManager.sharedInstance.locations[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss, MM-dd-yyyy"
        
        cell.textLabel?.text = "\(entry.coordinate.latitude), \(entry.coordinate.longitude) "
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(entry.timestamp)
        
        return cell
    }
    
    
}
















