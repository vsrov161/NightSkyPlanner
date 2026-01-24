//
//  SightsViewController.swift
//  NightSkyPlanner
//
//  Created by Vic on 22.01.2026.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    // object that works with geolocation
    private let locationManager = CLLocationManager()
    
    // map
    private var mapView: MKMapView!
    
    // find location pin
    private var locateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocateButton()
        setupLocationManager()
    }
    
    private func setupMapView() {
        mapView = MKMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLocateButton() {
        locateButton = UIButton(type: .system)
        locateButton.setImage(UIImage(systemName: "location"), for: .normal)
        locateButton.tintColor = .systemGreen
        locateButton.setTitleColor(.white, for: .normal)
        locateButton.layer.cornerRadius = 8
        locateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locateButton)
        
        NSLayoutConstraint.activate([
            locateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            locateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            locateButton.widthAnchor.constraint(equalToConstant: 50),
            locateButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        locateButton.addTarget(self, action: #selector(locateMeTapped), for: .touchUpInside)
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // ask for authorization
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: Actions
    @objc private func locateMeTapped() {
        guard let location = locationManager.location?.coordinate else {
            print("location is unavailable")
            return
        }
        
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        
        mapView.setRegion(region, animated: true)
    }
}

// MARK: CLLocation manager delegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // update ui here if new data arrived
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        default:
            mapView.showsUserLocation = false
        }
    }
}
