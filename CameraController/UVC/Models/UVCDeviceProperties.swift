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
        let interfaceId = device.descriptor.interfaceID

        scanningMode = UVCBoolControl(interface, 1, UVCCameraTerminal.scanningMode, camerTerminalId, interfaceId)
        exposureMode = UVCBitmapControl(interface, 1, UVCCameraTerminal.aeMode, camerTerminalId, interfaceId)
        exposurePriority = UVCIntControl(interface, 1, UVCCameraTerminal.aePriority, camerTerminalId, interfaceId)
        exposureTime = UVCIntControl(interface, 4, UVCCameraTerminal.exposureTimeAbsolute, camerTerminalId, interfaceId)
        focusAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.focusAbsolute, camerTerminalId, interfaceId)
        focusAuto = UVCBoolControl(interface, 1, UVCCameraTerminal.focusAuto, camerTerminalId, interfaceId)
        irisAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.irisAbsolute, camerTerminalId, interfaceId)
        zoomAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.zoomAbsolute, camerTerminalId, interfaceId)
        panTiltAbsolute = UVCMultipleIntControl(interface, 8, UVCCameraTerminal.pantiltAbsolute,
                                                camerTerminalId, interfaceId)
        rollAbsolute = UVCIntControl(interface, 2, UVCCameraTerminal.rollAbsolute, camerTerminalId, interfaceId)

        backlightCompensation = UVCIntControl(interface, 2, UVCProcessingUnit.backlightCompensation,
                                              processingUnitId, interfaceId)
        brightness = UVCIntControl(interface, 2, UVCProcessingUnit.brightness, processingUnitId, interfaceId)
        contrast = UVCIntControl(interface, 2, UVCProcessingUnit.contrast, processingUnitId, interfaceId)
        contrastAuto = UVCBoolControl(interface, 1, UVCProcessingUnit.contrastAuto, processingUnitId, interfaceId)
        gain = UVCIntControl(interface, 2, UVCProcessingUnit.gain, processingUnitId, interfaceId)
        powerLineFrequency = UVCIntControl(interface, 2, UVCProcessingUnit.powerLineFrequency,
                                           processingUnitId, interfaceId)
        hue = UVCIntControl(interface, 2, UVCProcessingUnit.hue, processingUnitId, interfaceId)
        hueAuto = UVCBoolControl(interface, 1, UVCProcessingUnit.hueAuto, processingUnitId, interfaceId)
        saturation = UVCIntControl(interface, 2, UVCProcessingUnit.saturation, processingUnitId, interfaceId)
        sharpness = UVCIntControl(interface, 2, UVCProcessingUnit.sharpness, processingUnitId, interfaceId)
        gamma = UVCIntControl(interface, 2, UVCProcessingUnit.gamma, processingUnitId, interfaceId)
        whiteBalance = UVCIntControl(interface, 2, UVCProcessingUnit.whiteBalanceTemperature,
                                     processingUnitId, interfaceId)
        whiteBalanceAuto = UVCBoolControl(interface, 1, UVCProcessingUnit.whiteBalanceTemperatureAuto,
                                          processingUnitId, interfaceId)
    }
}
