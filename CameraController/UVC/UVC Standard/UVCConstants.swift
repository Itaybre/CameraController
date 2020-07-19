//
//  UVCConstants.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

struct UVCConstants {
    static let UVC_CC_VIDEO = 0x0E
    static let UVC_SC_VIDEOCONTROL = 0x01
    static let UVC_CS_INTERFACE = 0x24
    
    static let UVC_VC_INPUT_TERMINAL = 0x02
    static let UVC_VC_SELECTOR_UNIT = 0x04
    static let UVC_VC_PROCESSING_UNIT = 0x05
    static let UVC_VC_EXTENSION_UNIT = 0x06
    
    static let UVC_INPUT_TERMINAL_ID: Int = 0x01
    static let UVC_PROCESSING_UNIT_ID: Int = 0x02
}
