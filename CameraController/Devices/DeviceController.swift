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

    func getSettings() -> DeviceSettings {
        return DeviceSettings(exposureMode: self.exposureMode.selected.rawValue,
                              exposureTime: self.exposureTime.sliderValue,
                              gain: self.gain.sliderValue,
                              brightness: self.brightness.sliderValue,
                              contrast: self.contrast.sliderValue,
                              saturation: self.saturation.sliderValue,
                              sharpness: self.sharpness.sliderValue,
                              whiteBalanceAuto: self.whiteBalanceAuto.isEnabled,
                              whiteBalance: self.whiteBalance.sliderValue,
                              powerline: self.powerLineFrequency.sliderValue,
                              backlightCompensation: self.backlightCompensation.sliderValue,
                              zoom: self.zoomAbsolute.sliderValue,
                              pan: self.panTiltAbsolute.sliderValue1,
                              tilt: self.panTiltAbsolute.sliderValue2,
                              focusAuto: self.focusAuto.isEnabled,
                              focus: self.focusAbsolute.sliderValue)
    }

    func set(_ deviceSettings: DeviceSettings) {
        self.exposureMode.selected = UVCBitmapControl.BitmapValue(rawValue: deviceSettings.exposureMode) ?? .auto
        self.exposureTime.sliderValue = deviceSettings.exposureTime
        self.gain.sliderValue = deviceSettings.gain
        self.brightness.sliderValue = deviceSettings.brightness
        self.contrast.sliderValue = deviceSettings.contrast
        self.saturation.sliderValue = deviceSettings.saturation
        self.sharpness.sliderValue = deviceSettings.sharpness
        self.whiteBalanceAuto.isEnabled = deviceSettings.whiteBalanceAuto
        self.whiteBalance.sliderValue = deviceSettings.whiteBalance
        self.powerLineFrequency.sliderValue = deviceSettings.powerline
        self.backlightCompensation.sliderValue = deviceSettings.backlightCompensation
        self.zoomAbsolute.sliderValue = deviceSettings.zoom
        self.panTiltAbsolute.sliderValue1 = deviceSettings.pan
        self.panTiltAbsolute.sliderValue2 = deviceSettings.tilt
        self.focusAuto.isEnabled = deviceSettings.focusAuto
        self.focusAbsolute.sliderValue = deviceSettings.focus
    }

    func resetDefault() {
        self.exposureMode.reset()
        self.exposureTime.reset()
        self.gain.reset()
        self.brightness.reset()
        self.contrast.reset()
        self.saturation.reset()
        self.sharpness.reset()
        self.whiteBalanceAuto.reset()
        self.whiteBalance.reset()
        self.powerLineFrequency.reset()
        self.backlightCompensation.reset()
        self.zoomAbsolute.reset()
        self.panTiltAbsolute.reset()
        self.panTiltAbsolute.reset()
        self.focusAuto.reset()
        self.focusAbsolute.reset()
    }
}
