//
//  ViewController.swift
//  GetLocation
//
//  Created by Ben Liu on 26/09/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

import UIKit
import CoreLocation     // add the import

// inherit from the class CLLocationManagerDelegate
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    // initialize a
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var label_location: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // There are two types of location access
        // 1.requestWhenInUseAuthorization
        // 2.requestAlwaysAuthorization
        locationManager.requestWhenInUseAuthorization()

    }
    
    
    
    // Button function
    @IBAction func findMyLocation(sender: AnyObject) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    // implement the override function
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    // implement the override function
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    // implement the function
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            // print out the msg on the console
            println(locality)
            println(postalCode)
            println(administrativeArea)
            println(country)
            
            // print out the msg on the label
            label_location.text = locality+"\n"+country
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
