//
//  ViewControllerPresenterTests.swift
//  WifiDetectorTests
//
//  Created by Sani on 22/08/2021.
//

import XCTest
@testable import WifiDetector

class ViewControllerPresenterTests: XCTestCase {
    
    func testSSIDReturnsSSIDNameWhenWifiProviderReturnsName() throws {
        let presenter = ViewControllerPresenter(wifiInfoProvider: MockWifiProvider(ssidToReturn: "Sani"),
                                                model: ViewModel(),
                                                locationManager: MockLocationManager())
        
        presenter.retrieveCurrentWifiName()
        let ssid = presenter.ssidName
        XCTAssertTrue(ssid == "Sani", "SSID returned not the same")
    }
    
    func testSSIDReturnsEmptyStringWhenWifiProviderReturnsNil() throws {
        let presenter = ViewControllerPresenter(wifiInfoProvider: MockWifiProvider(ssidToReturn: nil),
                                                model: ViewModel(),
                                                locationManager: MockLocationManager())
        
        presenter.retrieveCurrentWifiName()
        let ssid = presenter.ssidName
        XCTAssertTrue(ssid == "", "SSID returned not empty string: \(ssid)")
    }
    
    func testAuthorizationStatusDeniedReturnsNotAuthorizedStatus() throws {
        let mockManager = MockLocationManager()
        mockManager.expectedAuthorizationStatus = .denied

        let presenter = ViewControllerPresenter(wifiInfoProvider: MockWifiProvider(),
                                                model: ViewModel(),
                                                locationManager: mockManager)
        presenter.bottomButtonPressed {}
        
        let state = presenter.currentPermissionState
        XCTAssertTrue(state == .notAuthorised, "CLAuthorizationStatusDenied does not return Not Authorised: \(state)")
    }
    
    func testAuthorizationStatusAuthorizedAlwaysReturnsAuthorizedStatus() throws {
        let mockManager = MockLocationManager()
        mockManager.expectedAuthorizationStatus = .authorizedAlways

        let presenter = ViewControllerPresenter(wifiInfoProvider: MockWifiProvider(),
                                                model: ViewModel(),
                                                locationManager: mockManager)
        presenter.bottomButtonPressed {}
        
        let state = presenter.currentPermissionState
        XCTAssertTrue(state == .authorised, "CLAuthorizationStatusAlways does not return Authorised: \(state)")
    }
    
    func testAuthorizationStatusAuthorizedWhenInUseAlwaysReturnsAuthorizedStatus() throws {
        let mockManager = MockLocationManager()
        mockManager.expectedAuthorizationStatus = .authorizedWhenInUse

        let presenter = ViewControllerPresenter(wifiInfoProvider: MockWifiProvider(),
                                                model: ViewModel(),
                                                locationManager: mockManager)
        presenter.bottomButtonPressed {}
        
        let state = presenter.currentPermissionState
        XCTAssertTrue(state == .authorised, "CLAuthorizationAuthorizedWhenInUser does not return Authorised: \(state)")
        
    }
}
