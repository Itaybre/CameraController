//
//  CaptureDevice.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

class CaptureDevice: Hashable, ObservableObject {
    let name: String
    let avDevice: AVCaptureDevice?
    let uvcDevice: UVCDevice?
    var controller: DeviceController?

    init(avDevice: AVCaptureDevice) {
        self.avDevice = avDevice
        self.name = avDevice.localizedName
        self.uvcDevice = try? UVCDevice(device: avDevice)
        self.controller = DeviceController(properties: uvcDevice?.properties)
    }

    static func == (lhs: CaptureDevice, rhs: CaptureDevice) -> Bool {
        return lhs.avDevice == rhs.avDevice
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(avDevice)
    }

    func isConfigurable() -> Bool {
        return uvcDevice != nil
    }

    func isDefaultDevice() -> Bool {
        return false
    }

    func readValuesFromDevice() {
        if let controller = controller {
            controller.exposureTime.update()
            controller.whiteBalance.update()
            controller.focusAbsolute.update()
            controller.objectWillChange.send()
        }
    }

    func writeValuesToDevice() {
        if let controller = controller {
            controller.writeValues()
        }
    }
}
