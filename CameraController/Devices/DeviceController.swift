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
    @Published var brightness: IntCaptureDeviceProperty
    @Published var contrast: IntCaptureDeviceProperty
    @Published var saturation: IntCaptureDeviceProperty
    @Published var sharpness: IntCaptureDeviceProperty
    @Published var whiteBalanceAuto: BoolCaptureDeviceProperty
    @Published var whiteBalance: IntCaptureDeviceProperty
    @Published var powerLineFrequency: IntCaptureDeviceProperty

    init?(properties: UVCDeviceProperties?) {
        guard let properties = properties else {
            return nil
        }

        // Exposure
        exposureMode = BitmapCaptureDeviceProperty(properties.exposureMode)
        exposureTime = IntCaptureDeviceProperty(properties.exposureTime)
        gain = IntCaptureDeviceProperty(properties.gain)

        // Image
        brightness = IntCaptureDeviceProperty(properties.brightness)
        contrast = IntCaptureDeviceProperty(properties.contrast)
        saturation = IntCaptureDeviceProperty(properties.saturation)
        sharpness = IntCaptureDeviceProperty(properties.sharpness)

        // WhiteBalance
        whiteBalanceAuto = BoolCaptureDeviceProperty(properties.whiteBalanceAuto)
        whiteBalance = IntCaptureDeviceProperty(properties.whiteBalance)

        // PowerLine
        powerLineFrequency = IntCaptureDeviceProperty(properties.powerLineFrequency)
    }
}
