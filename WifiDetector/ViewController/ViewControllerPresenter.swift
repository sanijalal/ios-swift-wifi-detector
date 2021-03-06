//
//  ViewControllerPresenter.swift
//  WifiDetector
//
//  Created by Sani on 21/08/2021.
//

import Foundation
import CoreLocation

class ViewControllerPresenter: NSObject {
    private var viewmodel: ViewModel
    private var wifiInfoProvider: WifiInfoProviding
    private var locationManager: LocationInfoManaging
    private var currentLocationPermissionCallback: (() -> Void)?
    
    init(wifiInfoProvider: WifiInfoProviding, model: ViewModel = ViewModel(), locationManager: LocationInfoManaging = LocationInfoManager()) {
        self.viewmodel = model
        self.wifiInfoProvider = wifiInfoProvider
        self.locationManager = locationManager
        super.init()
        self.updateLocationPermissionState(status: locationManager.getAuthorizationStatus())
        self.locationManager.delegate = self
    }
    
    var labelText: String {
        switch viewmodel.locationPermissionState {
        case .authorised:
            var textToShow = "Authorised"
            if let ssidName = viewmodel.ssidName {
                textToShow += " SSID: \(ssidName)"
            }
            return textToShow
        case .notAuthorised:
            return "Not Authorised"
        case .unknown:
            return "Unknown"
        }
    }
    
    var buttonText: String {
        switch viewmodel.locationPermissionState {
        case .authorised:
            return "Get SSID"
        case .notAuthorised:
            return "Go to Settings" // This will not be shown
        case .unknown:
            return "Request Permission"
        }
    }
    
    var ssidName: String {
        return viewmodel.ssidName ?? ""
    }
    
    var currentPermissionState: LocationPermissionState {
        return viewmodel.locationPermissionState
    }
    
    var hasRequestedSSID: Bool {
        return viewmodel.hasRequestedSSID
    }
    
    private func updateLocationPermissionState(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            viewmodel.locationPermissionState = .authorised
        case .denied, .restricted:
            viewmodel.locationPermissionState = .notAuthorised
        case .notDetermined:
            viewmodel.locationPermissionState = .unknown
        default:
            viewmodel.locationPermissionState = .unknown
        }
    }
    
    func retrieveCurrentWifiName() {
        viewmodel.hasRequestedSSID = true
        viewmodel.ssidName = self.wifiInfoProvider.getSSID()
    }
    
    func bottomButtonPressed(callback: @escaping ( () -> Void )) {
        currentLocationPermissionCallback = callback
        switch viewmodel.locationPermissionState {
        case .authorised:
            self.retrieveCurrentWifiName()
            callback()
        case .notAuthorised:
            self.locationManager.requestWhenInUseAuthorization()
        case .unknown:
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    deinit {
        self.locationManager.delegate = nil
    }
}

extension ViewControllerPresenter: LocationPermissionDelegating {
    func permissionStatusReturned(_ status: CLAuthorizationStatus) {
        updateLocationPermissionState(status: status)
        if let callback = currentLocationPermissionCallback {
            callback()
        }
    }
}
