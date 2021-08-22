//
//  LocationPermissionDelegate.swift
//  WifiDetector
//
//  Created by Sani on 22/08/2021.
//

import Foundation
import CoreLocation

class LocationPermissionDelegate: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationPermissionDelegating?
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let delegate = delegate else { return }
        delegate.permissionStatusReturned(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let delegate = delegate else { return }
        delegate.permissionStatusReturned(status)
    }
}
