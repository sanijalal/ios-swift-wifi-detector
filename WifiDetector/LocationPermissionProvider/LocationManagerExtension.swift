//
//  LocationManagerExtension.swift
//  WifiDetector
//
//  Created by Sani on 21/08/2021.
//

import Foundation
import CoreLocation

extension CLLocationManager: LocationInfoManaging {
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return self.authorizationStatus
    }
}
