//
//  USBDevice.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import IOKit.usb

struct USBDevice {
    let interface: UnsafeMutablePointer<UnsafeMutablePointer<IOUSBInterfaceInterface190>>
    let descriptor: UVCDescriptor
}
