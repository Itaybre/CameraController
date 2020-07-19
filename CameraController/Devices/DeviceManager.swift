//
//  DeviceManager.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import AVFoundation

class DevicesManager {
    static let shared = DevicesManager()
    
    var devices: [AVCaptureDevice] = []
    
    private init() {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.externalUnknown, .builtInWideAngleCamera],
                                                                mediaType: nil,
                                                                position: .unspecified)
        devices = discoverySession.devices
    }
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceAdded(notif:)),
                                               name: NSNotification.Name.AVCaptureDeviceWasConnected,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deviceRemoved(notif:)),
                                               name: NSNotification.Name.AVCaptureDeviceWasDisconnected,
                                               object: nil)
    }
    
    func stopMonitoring() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.AVCaptureDeviceWasConnected,
                                                  object: nil)
    }
    
    @objc func deviceAdded(notif: NSNotification) {
        guard let device = notif.object as? AVCaptureDevice else {
            return
        }
        
        devices.append(device)
    }
    
    @objc func deviceRemoved(notif: NSNotification) {
        let device = notif.object as! AVCaptureDevice
        if let index = devices.firstIndex(of: device) {
            devices.remove(at: index)
        }
    }
}
