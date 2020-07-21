//
//  UVCProcessingUnitConstants.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

enum UVCProcessingUnit: Int, Selector {
    case backlightCompensation = 0x01
    case brightness = 0x02
    case contrast = 0x03
    case gain = 0x04
    case powerLineFrequency = 0x05
    case hue = 0x06
    case saturation = 0x07
    case sharpness = 0x08
    case gamma = 0x09
    case whiteBalanceTemperature = 0x0A
    case whiteBalanceTemperatureAuto = 0x0B
    case whiteBalanceComponent = 0x0C
    case whiteBalanceComponentAuto = 0x0D
    case digitalMultiplier = 0x0E
    case digitalMultiplierLimit = 0x0F
    case hueAuto = 0x10
    case analogVideoStandard = 0x11
    case analogLockStatus = 0x12
    case contrastAuto = 0x13

    func raw() -> Int {
        return self.rawValue
    }
}
