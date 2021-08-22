//
//  MockLocationManagerDelegate.swift
//  WifiDetectorTests
//
//  Created by Sani on 22/08/2021.
//

import Foundation
import CoreLocation
@testable import WifiDetector

class MockLocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    var fixedStatus: CLAuthorizationStatus = .notDetermined
    weak var delegate: LocationPermissionDelegating?
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let delegate = delegate else { return }
        delegate.permissionStatusReturned(fixedStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let delegate = delegate else { return }
        delegate.permissionStatusReturned(status)
    }
}
