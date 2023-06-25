//
//  UVCRequestCodes.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

enum UVCRequestCodes: UInt8 {
    case setCurrent = 0x01
    case getCurrent = 0x81
    case getMinimum = 0x82
    case getMaximum = 0x83
    case getRessolution = 0x84
    case getLength = 0x85
    case getInfo = 0x86
    case getDefault = 0x87
}
