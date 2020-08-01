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
    @Published var exposureTime: NumberCaptureDeviceProperty
    @Published var gain: NumberCaptureDeviceProperty
    @Published var brightness: NumberCaptureDeviceProperty
    @Published var contrast: NumberCaptureDeviceProperty
    @Published var saturation: NumberCaptureDeviceProperty
    @Published var sharpness: NumberCaptureDeviceProperty
    @Published var whiteBalanceAuto: BoolCaptureDeviceProperty
    @Published var whiteBalance: NumberCaptureDeviceProperty
    @Published var powerLineFrequency: NumberCaptureDeviceProperty
    @Published var backlightCompensation: NumberCaptureDeviceProperty
    @Published var zoomAbsolute: NumberCaptureDeviceProperty
    @Published var panTiltAbsolute: MultipleCaptureDeviceProperty
    @Published var focusAuto: BoolCaptureDeviceProperty
    @Published var focusAbsolute: NumberCaptureDeviceProperty

    init?(properties: UVCDeviceProperties?) {
        guard let properties = properties else {
            return nil
        }

        // Exposure
        exposureMode = BitmapCaptureDeviceProperty(properties.exposureMode)
        exposureTime = NumberCaptureDeviceProperty(properties.exposureTime)
        gain = NumberCaptureDeviceProperty(properties.gain)

        // Image
        brightness = NumberCaptureDeviceProperty(properties.brightness)
        contrast = NumberCaptureDeviceProperty(properties.contrast)
        saturation = NumberCaptureDeviceProperty(properties.saturation)
        sharpness = NumberCaptureDeviceProperty(properties.sharpness)

        // WhiteBalance
        whiteBalanceAuto = BoolCaptureDeviceProperty(properties.whiteBalanceAuto)
        whiteBalance = NumberCaptureDeviceProperty(properties.whiteBalance)

        // PowerLine
        powerLineFrequency = NumberCaptureDeviceProperty(properties.powerLineFrequency)

        // Backlight Compensation
        backlightCompensation = NumberCaptureDeviceProperty(properties.backlightCompensation)

        // Orientation
        zoomAbsolute = NumberCaptureDeviceProperty(properties.zoomAbsolute)
        panTiltAbsolute = MultipleCaptureDeviceProperty(properties.panTiltAbsolute)

        // Focus
        focusAuto = BoolCaptureDeviceProperty(properties.focusAuto)
        focusAbsolute = NumberCaptureDeviceProperty(properties.focusAbsolute)
    }

    func writeValues() {
        exposureMode.write()
        exposureTime.write()
        gain.write()
        brightness.write()
        contrast.write()
        saturation.write()
        sharpness.write()
        whiteBalanceAuto.write()
        whiteBalance.write()
        powerLineFrequency.write()
        backlightCompensation.write()
        zoomAbsolute.write()
        panTiltAbsolute.write()
        focusAuto.write()
        focusAbsolute.write()
    }
}
