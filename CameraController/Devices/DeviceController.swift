//
//  DeviceController.swift
//  CameraController
//
//  Created by Itay Brenner on 7/23/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import Combine

class DeviceController: ObservableObject {
    @Published var exposureMode: BitmapCaptureDeviceProperty
    @Published var exposureTime: IntCaptureDeviceProperty
    @Published var gain: IntCaptureDeviceProperty

    init?(properties: UVCDeviceProperties?) {
        guard let properties = properties else {
            return nil
        }

        exposureMode = BitmapCaptureDeviceProperty(properties.exposureMode)
        exposureTime = IntCaptureDeviceProperty(properties.exposureTime)
        gain = IntCaptureDeviceProperty(properties.gain)
    }
}
