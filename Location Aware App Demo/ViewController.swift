//
//  ViewController.swift
//  Location Aware App Demo
//
//  Created by Mohammad Kiani on 2020-06-12.
//  Copyright © 2020 mohammadkiani. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // we need a location manager
    var locationManager = CLLocationManager()

    @IBOutlet weak var latitudeLbl: UILabel!
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var courseLbl: UILabel!
    @IBOutlet weak var altitudeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // we give the delegate of locationManager to this class
        locationManager.delegate = self
        
        // accuracy of the location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // request the user for the location access
        locationManager.requestWhenInUseAuthorization()
        
        // start updating the location of the user
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
//        print(location)
        
        latitudeLbl.text = String(location.coordinate.latitude)
        longitudeLbl.text = String(location.coordinate.longitude)
        speedLbl.text = String(location.speed)
        courseLbl.text = String(location.course)
        altitudeLbl.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error!)
            } else {
                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + "\n"
                    }
                    
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    
                    if placemark.country != nil {
                        address += placemark.country! + "\n"
                    }
                    
                    self.addressLbl.text = address
                }
            }
        }
        
    }


}

