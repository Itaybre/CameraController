//
//  UVCCameraTerminalConstants.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

enum UVCCameraTerminal: Int, Selector {
    case scanningMode = 0x01
    case aeMode = 0x02
    case aePriority = 0x03
    case exposureTimeAbsolute = 0x04
    case exposureTimeRelative = 0x05
    case focusAbsolute = 0x06
    case focusRelative = 0x07
    case focusAuto = 0x08
    case irisAbsolute = 0x09
    case irisRelative = 0x0A
    case zoomAbsolute = 0x0B
    case zoomRelative = 0x0C
    case pantiltAbsolute = 0x0D
    case pantiltRelative = 0x0E
    case rollAbsolute = 0x0F
    case rollRelative = 0x10
    case privacy = 0x11
    case focusSimple = 0x12
    case digitalWindow = 0x13
    case regionOfInterest = 0x14

    func raw() -> Int {
        return self.rawValue
    }
}
