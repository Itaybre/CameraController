//
//  UVCConstants.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

struct UVCConstants {
    static let classVideo: UInt16 = 0x0E
    static let subclassVideoControl: UInt16 = 0x01
    static let descriptorTypeInterface = 0x24

    enum DescriptorSubtype: UInt8 {
        case inputTerminal = 0x02
        case selectorUnit = 0x04
        case processingUnit = 0x05
        case extensionUnit = 0x06
    }

    enum Unit: UInt8 {
        case inputTerminal = 0x01
        case processingUnit = 0x02
    }
}
