//
//  LocationInfoManaging.swift
//  WifiDetector
//
//  Created by Sani on 21/08/2021.
//

import Foundation
import CoreLocation

protocol LocationInfoManaging {
    var delegate: CLLocationManagerDelegate? { get set }
    
    func requestWhenInUseAuthorization()
    func getAuthorizationStatus() -> CLAuthorizationStatus
}
