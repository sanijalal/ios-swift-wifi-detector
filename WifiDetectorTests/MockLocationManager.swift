//
//  MockLocationManager.swift
//  WifiDetectorTests
//
//  Created by Sani on 22/08/2021.
//

import Foundation
import CoreLocation
@testable import WifiDetector

class MockLocationManager: LocationInfoManaging {
    var delegate: CLLocationManagerDelegate?
    var expectedAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    func requestWhenInUseAuthorization() {
        if let delegate = delegate {
            if #available(iOS 14, *) {
                delegate.locationManagerDidChangeAuthorization?(CLLocationManager())
            } else {
                delegate.locationManager?(CLLocationManager(), didChangeAuthorization: expectedAuthorizationStatus)
            }
        }
    }

    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return expectedAuthorizationStatus
    }
}
