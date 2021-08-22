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
    var delegate: LocationPermissionDelegating?
    var expectedAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    func requestWhenInUseAuthorization() {
        delegate?.permissionStatusReturned(expectedAuthorizationStatus)
    }

    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return expectedAuthorizationStatus
    }
}
