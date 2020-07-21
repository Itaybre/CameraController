//
//  UVCDeviceProperties.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

class UVCDeviceProperties {
    var scanningMode: UVCBoolControl
    var exposureMode: UVCBitmapControl
    var exposurePriority: UVCIntControl
    var exposureTime: UVCIntControl
    var focusAbsolute: UVCIntControl
    var focusAuto: UVCBoolControl
    var irisAbsolute: UVCIntControl
    var zoomAbsolute: UVCIntControl
    var panTiltAbsolute: UVCMultipleIntControl
    var rollAbsolute: UVCIntControl
    
    var backlightCompensation: UVCIntControl
    var brightness: UVCIntControl
    var contrast: UVCIntControl
    var contrastAuto: UVCBoolControl
    var gain: UVCIntControl
    var powerLineFrequency: UVCIntControl
    var hue: UVCIntControl
    var hueAuto: UVCBoolControl
    var saturation: UVCIntControl
    var sharpness: UVCIntControl
    var gamma: UVCIntControl
    var whiteBalance: UVCIntControl
    var whiteBalanceAuto: UVCBoolControl

    init(_ device: USBDevice) {
        let interface = device.interface
        let camerTerminalId = device.descriptor.cameraTerminalID
        let processingUnitId = device.descriptor.processingUnitID

        scanningMode = UVCBoolControl(interface, 1, UVCCameraTerminal.scanningMode, camerTerminalId)
        exposureMode = UVCBitmapControl(interface, 1, UVCCameraTerminal.aeMode, camerTerminalId)
        exposurePriority = UVCIntControl(interface, 1, UVCCameraTerminal.aePriority, camerTerminalId)
        exposureTime = UVCIntControl(interface, 4, UVCCameraTerminal.exposureTimeAbsolute, camerTerminalId)
        focusAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.focusAbsolute, camerTerminalId)
        focusAuto = UVCBoolControl(interface, 1, UVCCameraTerminal.focusAuto, camerTerminalId)
        irisAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.irisAbsolute, camerTerminalId)
        zoomAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.zoomAbsolute, camerTerminalId)
        panTiltAbsolute = UVCMultipleIntControl(interface, 8, UVCCameraTerminal.pantiltAbsolute, camerTerminalId)
        rollAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.rollAbsolute, camerTerminalId)

        backlightCompensation = UVCIntControl(interface, 2, UVCProcessingUnit.backlightCompensation, processingUnitId)
        brightness = UVCIntControl(interface, 2, UVCProcessingUnit.brightness, processingUnitId)
        contrast = UVCIntControl(interface, 2, UVCProcessingUnit.contrast, processingUnitId)
        contrastAuto = UVCBoolControl(interface, 1, UVCProcessingUnit.contrastAuto, processingUnitId)
        gain = UVCIntControl(interface, 2, UVCProcessingUnit.gain, processingUnitId)
        powerLineFrequency = UVCIntControl(interface, 2, UVCProcessingUnit.powerLineFrequency, processingUnitId)
        hue = UVCIntControl(interface, 2, UVCProcessingUnit.hue, processingUnitId)
        hueAuto = UVCBoolControl(interface, 1, UVCProcessingUnit.hueAuto, processingUnitId)
        saturation = UVCIntControl(interface, 2, UVCProcessingUnit.saturation, processingUnitId)
        sharpness = UVCIntControl(interface, 2, UVCProcessingUnit.sharpness, processingUnitId)
        gamma = UVCIntControl(interface, 2, UVCProcessingUnit.gamma, processingUnitId)
        whiteBalance = UVCIntControl(interface, 2, UVCProcessingUnit.whiteBalanceTemperature, processingUnitId)
        whiteBalanceAuto = UVCBoolControl(interface, 1, UVCProcessingUnit.whiteBalanceTemperatureAuto, processingUnitId)
    }
}
