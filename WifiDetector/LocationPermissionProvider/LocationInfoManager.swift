//
//  LocationInfoManager.swift
//  WifiDetector
//
//  Created by Sani on 22/08/2021.
//

import Foundation
import CoreLocation

class LocationInfoManager: NSObject, LocationInfoManaging {
    var delegate: LocationPermissionDelegating?
    private var locationManager: CLLocationManager!
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
    
    deinit {
        self.locationManager.delegate = nil
    }
}

extension LocationInfoManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let delegate = delegate else { return }
        delegate.permissionStatusReturned(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let delegate = delegate else { return }
        delegate.permissionStatusReturned(status)
    }
}
