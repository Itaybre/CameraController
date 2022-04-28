//
//  UVCControl.swift
//  CameraController
//
//  Created by Itay Brenner on 7/20/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

protocol Selector {
    func raw() -> Int
}

class UVCControl {
    let interface: USBInterfacePointer
    let uvcSize: Int
    let uvcSelector: Int
    let uvcUnit: Int
    let uvcInterface: Int

    var isCapable: Bool = false

    init(_ interface: USBInterfacePointer, _ uvcSize: Int, _ uvcSelector: Selector,
         _ uvcUnit: Int, _ uvcInterface: Int) {
        self.interface = interface
        self.uvcSize = uvcSize
        self.uvcSelector = uvcSelector.raw()
        self.uvcUnit = uvcUnit
        self.uvcInterface = uvcInterface
    }

    func getDataFor(type: UVCRequestCodes, length: Int) -> Int {

        guard uvcUnit >= 0 else { return 0 }

        var value: Int = 0

        let requestType = USBmakebmRequestType(direction: kUSBIn, type: kUSBClass, recipient: kUSBInterface)

        var request: IOUSBDevRequest = IOUSBDevRequest(bmRequestType: requestType,
                                                       bRequest: UInt8(type.rawValue),
                                                       wValue: UInt16(uvcSelector<<8),
                                                       wIndex: UInt16(uvcUnit<<8) | UInt16(uvcInterface),
                                                       wLength: UInt16(length),
                                                       pData: &value,
                                                       wLenDone: 0)
        if #available(macOS 12.0, *) {
            guard
                interface.pointee.pointee.ControlRequest(interface, 0, &request) == kIOReturnSuccess else {
                    return 0
            }
        } else {
            guard
                interface.pointee.pointee.USBInterfaceOpenSeize(interface) == kIOReturnSuccess,
                interface.pointee.pointee.ControlRequest(interface, 0, &request) == kIOReturnSuccess,
                interface.pointee.pointee.USBInterfaceClose(interface) == kIOReturnSuccess else {
                    return 0
            }
        }

        return value
    }

    func setData(value: Int, length: Int) -> Bool {

        guard uvcUnit >= 0 else { return false }

        var ref = value

        let requestType = USBmakebmRequestType(direction: kUSBOut, type: kUSBClass, recipient: kUSBInterface)

        var request: IOUSBDevRequest = IOUSBDevRequest(bmRequestType: requestType,
                                                       bRequest: UInt8(UVCRequestCodes.setCurrent.rawValue),
                                                       wValue: UInt16(uvcSelector<<8),
                                                       wIndex: UInt16(uvcUnit<<8) | UInt16(uvcInterface),
                                                       wLength: UInt16(length),
                                                       pData: &ref,
                                                       wLenDone: 0)

        if #available(macOS 12.0, *) {
            guard
                interface.pointee.pointee.ControlRequest(interface, 0, &request) == kIOReturnSuccess else {
                    return false
            }
        } else {
            guard
                interface.pointee.pointee.USBInterfaceOpenSeize(interface) == kIOReturnSuccess,
                interface.pointee.pointee.ControlRequest(interface, 0, &request) == kIOReturnSuccess,
                interface.pointee.pointee.USBInterfaceClose(interface) == kIOReturnSuccess else {
                    return false
            }
        }

        return true
    }

    func updateIsCapable() {
        isCapable = getDataFor(type: UVCRequestCodes.getInfo, length: 1) != 0
    }

    func USBmakebmRequestType(direction: Int, type: Int, recipient: Int) -> UInt8 {
        return UInt8((direction & kUSBRqDirnMask) << kUSBRqDirnShift) |
            UInt8((type & kUSBRqTypeMask) << kUSBRqTypeShift)|UInt8(recipient & kUSBRqRecipientMask)

    }
}
