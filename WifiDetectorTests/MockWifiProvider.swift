//
//  MockWifiProvider.swift
//  WifiDetectorTests
//
//  Created by Sani on 22/08/2021.
//

import Foundation
@testable import WifiDetector

struct MockWifiProvider: WifiInfoProviding {
    var ssidToReturn: String?
    
    func getSSID() -> String? {
        return ssidToReturn
    }
}
