//
//  RiderViewController.swift
//  UberClone
//
//  Created by Hein Htet Aung on 9/24/17.
//  Copyright © 2017 Hein Htet. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class RiderViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var callUberBtn: UIButton!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var uberHasBeenCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            userLocation = center
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            map.setRegion(region, animated: true)
            map.removeAnnotations(map.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "Your Location"
            map.addAnnotation(annotation)
        }
    }

    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        try? FIRAuth.auth()?.signOut()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callUberTapped(_ sender: UIButton) {
        if let email = FIRAuth.auth()?.currentUser?.email {
            
            if uberHasBeenCalled {
                uberHasBeenCalled = false
                callUberBtn.setTitle("Call an Uber", for: .normal)
                FIRDatabase.database().reference().child("RideRequest").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                    self.uberHasBeenCalled = true
                    self.callUberBtn.setTitle("Cancel Uber", for: .normal)
                    FIRDatabase.database().reference().child("RideRequest").removeAllObservers()
                })
            }else{
                let riderRequestDictionary : [String:Any] = ["email": email,"lat": userLocation.latitude, "lon": userLocation.longitude]
                FIRDatabase.database().reference().child("RideRequest").childByAutoId().setValue(riderRequestDictionary)
                uberHasBeenCalled = true
                callUberBtn.setTitle("Cancel Uber", for: .normal)
            }
        }
    }
}








