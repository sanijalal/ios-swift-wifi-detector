//
//  ViewModel.swift
//  WifiDetector
//
//  Created by Sani on 21/08/2021.
//

import Foundation

struct ViewModel {
    var ssidName: String?
    var locationPermissionState: LocationPermissionState = .unknown
    var hasRequestedSSID = false
}
