//
//  UVCConstants.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

struct UVCConstants {
    static let interfaceClassVideo = 0x0E
    static let interfaceSubclassVideoControl = 0x01
    static let descriptorTypeInterface = 0x24

    enum DescriptorSubtype: Int {
        case inputTerminal = 0x02
        case selectorUnit = 0x04
        case processingUnit = 0x05
        case extensionUnit = 0x06
    }

    enum Unit: Int {
        case inputTerminal = 0x01
        case processingUnit = 0x02
    }
}
