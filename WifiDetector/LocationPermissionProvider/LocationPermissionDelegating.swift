//
//  LocationPermissionDelegating.swift
//  WifiDetector
//
//  Created by Sani on 22/08/2021.
//

import Foundation
import CoreLocation

protocol LocationPermissionDelegating: AnyObject {
    func permissionStatusReturned(_ status: CLAuthorizationStatus)
}
