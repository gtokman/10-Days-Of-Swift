//
//  FlickrDatastore.swift
//  Project-1-Weatherful
//
//  Created by g tokman on 3/28/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import FlickrKit

class FlickrDatastore {
    private let OBJECTIVE_FLICKR_API_KEY = "6199076e79de327412533a7f166e122b"
    private let OBJECTIVE_FLICKR_API_SHARED_SECRET = "c16a75b94d3bec04"
    private let GROUP_ID = "1463451@N25"
    
    func retrieveImageAtLat(lat: Double, lon: Double, closure: (image: UIImage?) -> Void) {
        
        let fk = FlickrKit.sharedFlickrKit()
        fk.initializeWithAPIKey(OBJECTIVE_FLICKR_API_KEY, sharedSecret: OBJECTIVE_FLICKR_API_SHARED_SECRET)
        
        fk.call("flickr.photos.search", args: ["group_id": GROUP_ID, "lat": "\(lat)", "lon":"\(lon)", "radius": "10"], maxCacheAge: FKDUMaxAgeOneHour) {
            (response, error) in
            
            self.extractImageFk(fk, response: response, error: error, closure: closure)
            
        }
        
    }
    
    private func extractImageFk(fk: FlickrKit, response: AnyObject?, error: NSError?, closure: (image: UIImage?) -> Void) {
        
        if let response = response as? [String: AnyObject],
            photos = response["photos"] as? [String: AnyObject],
            listOfPhotos = photos["photo"] as? [[String: AnyObject]]
            where listOfPhotos.count > 0 {
            // print(listOfPhotos)
            
            // Get random photo
            let randomIndex = Int(arc4random_uniform(UInt32(listOfPhotos.count)))
            
            let photo = listOfPhotos[randomIndex]
            let url = fk.photoURLForSize(FKPhotoSizeMedium640, fromPhotoDictionary: photo)
            let image = UIImage(data: NSData(contentsOfURL: url)!)
            
            dispatch_async(dispatch_get_main_queue()) {
                closure(image: image!)
            }
            
        } else {
            print(error)
            print(response)
            
        }
        
    }
}
