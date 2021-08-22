//
//  AuthorisedWithSSID.swift
//  WifiDetector
//
//  Created by Sani on 22/08/2021.
//

import Foundation
import UIKit

class AuthorisedWithSSIDView: UIView {
    
    func updateSSID(ssidName: String) {
        displayLabel.text = "Your Wifi SSID is: \(ssidName)"
    }
    
    @IBOutlet weak var displayLabel: UILabel!
}
