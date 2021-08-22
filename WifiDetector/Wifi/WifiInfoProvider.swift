//
//  WifiInfoProvider.swift
//  WifiDetector
//
//  Created by Sani on 21/08/2021.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

struct WifiInfoProvider: WifiInfoProviding {
    func getSSID() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
}
