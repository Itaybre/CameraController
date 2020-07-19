//
//  DevicesManagerTests.swift
//  CameraControllerTests
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import XCTest
import AVFoundation
@testable import CameraController

class DevicesManagerTests: XCTestCase {

    override func setUpWithError() throws {
        DevicesManager.shared.devices = []
    }

    func testDefaultNoDevices() throws {
        let deviceManager = DevicesManager.shared
        
        XCTAssertEqual(deviceManager.devices.count, 0)
    }
    
    func testNotificationAddDevice() throws {
        let deviceManager = DevicesManager.shared
        
        let device = AVCaptureDevice.default(for: .video)
        let notification = NSNotification(name: NSNotification.Name(rawValue: "mockNotification"), object: device)
        
        deviceManager.deviceAdded(notif: notification)
        
        XCTAssertEqual(deviceManager.devices.count, 1)
        XCTAssertEqual(deviceManager.devices, [device])
    }
    
    func testNotificationRemoveDevice() throws {
        let deviceManager = DevicesManager.shared
        let device = AVCaptureDevice.default(for: .video)
        deviceManager.devices = [device!]
        XCTAssertEqual(deviceManager.devices.count, 1)
        
        let notification = NSNotification(name: NSNotification.Name(rawValue: "mockNotification"), object: device)
        deviceManager.deviceRemoved(notif: notification)
        
        XCTAssertEqual(deviceManager.devices.count, 0)
    }

}
