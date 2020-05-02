//
//  ViewController.swift
//  HelloMap0502
//
//  Created by 申潤五 on 2020/5/2.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationMgr:CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationMgr = CLLocationManager()
        locationMgr?.requestWhenInUseAuthorization()
//        locationMgr?.delegate = self
        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            if let location = self.locationMgr?.location?.coordinate{
                let xScale:CLLocationDegrees = 0.01
                let yScale:CLLocationDegrees = 0.01
                let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale,longitudeDelta: xScale)
                let region:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @IBAction func setMapType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let coordinate = locations[0].coordinate }
    
    
    @IBAction func longPressAction(_ sender: UILongPressGestureRecognizer) {
        
        print("Long Pressed")
        let viewLocationInMap = sender.location(in: mapView)
        print(viewLocationInMap)
        
        let location = mapView.convert(viewLocationInMap, toCoordinateFrom: mapView)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Point"
        annotation.subtitle = "My Point"
        self.mapView.addAnnotation(annotation)
        
    }
}

