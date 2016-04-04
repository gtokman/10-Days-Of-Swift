//
//  SecondViewController.swift
//  Project-6-Locator
//
//  Created by g tokman on 4/3/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var mapView: MKMapView?
    
    // MARK: Life Cycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let locations = DataManager.sharedInstance.locations
        var annotations = [MKPointAnnotation]()
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotations.insert(annotation, atIndex: annotations.count)
        }
        
        let oldAnnotations = mapView!.annotations
        mapView?.removeAnnotations(oldAnnotations)
        
        mapView?.addAnnotations(annotations)
        
        if (annotations.count > 0) {
            let region = MKCoordinateRegionMake(annotations[0].coordinate, MKCoordinateSpanMake(0.1, 0.1))
            mapView?.regionThatFits(region)
        }
        
        mapView?.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

