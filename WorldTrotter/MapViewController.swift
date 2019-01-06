//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Sam Reaves on 12/30/18.
//  Copyright © 2018 Sam Reaves. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController : UIViewController {
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager! = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    var showsUsersLocation: Bool = true
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        /* Adds the segmented control to the top of the map */
        let standardString = NSLocalizedString("standardString", comment: "String for Standard Map selection")
        let hybridString = NSLocalizedString("hybridString", comment: "String for Hybrid Map selection")
        let satelliteString = NSLocalizedString("satelliteString", comment: "String for Satellite Map selection")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
            
        case 1:
            mapView.mapType = .hybrid
            
        case 2:
            mapView.mapType = .satellite
        
        default:
            break
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined || authorizationStatus == .denied {
            locationManager.requestWhenInUseAuthorization()
        } else {
            mapView.showsUserLocation = true
            centerMapOnUsersLocation()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func centerMapOnUsersLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUsersLocation()
    }
}

