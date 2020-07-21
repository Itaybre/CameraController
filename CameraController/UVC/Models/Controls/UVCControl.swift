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
    let uvcUnit: UInt8

    var isCapable: Bool = false

    init(_ interface: USBInterfacePointer, _ uvcSize: Int, _ uvcSelector: Selector, _ uvcUnit: UVCConstants.Unit) {
        self.interface = interface
        self.uvcSize = uvcSize
        self.uvcSelector = uvcSelector.raw()
        self.uvcUnit = uvcUnit.rawValue
    }

    func getDataFor(type: UVCRequestCodes, length: Int) -> Int {
        var value: Int = 0

        // TODO: Get Request Type Dynamicaly
        let requestType = UInt8(161)

        var request: IOUSBDevRequest = IOUSBDevRequest(bmRequestType: requestType,
                                                       bRequest: type.rawValue,
                                                       wValue: UInt16(uvcSelector<<8),
                                                       wIndex: UInt16(uvcUnit<<8),
                                                       wLength: UInt16(length),
                                                       pData: &value,
                                                       wLenDone: 0)
        guard
        interface.pointee.pointee.USBInterfaceOpen(interface) == kIOReturnSuccess,
        interface.pointee.pointee.ControlRequest(interface, 0, &request) == kIOReturnSuccess,
        interface.pointee.pointee.USBInterfaceClose(interface) == kIOReturnSuccess else {
            return 0
        }

        return value
    }

    func setData(value: Int, length: Int) -> Bool {
        var ref = value

        // TODO: Get Request Type Dynamicaly
        let requestType = UInt8(33)

        var request: IOUSBDevRequest = IOUSBDevRequest(bmRequestType: requestType,
                                                       bRequest: UVCRequestCodes.setCurrent.rawValue,
                                                       wValue: UInt16(uvcSelector<<8),
                                                       wIndex: UInt16(uvcUnit<<8),
                                                       wLength: UInt16(length),
                                                       pData: &ref,
                                                       wLenDone: 0)

        guard
            interface.pointee.pointee.USBInterfaceOpen(interface) == kIOReturnSuccess,
            interface.pointee.pointee.ControlRequest(interface, 0, &request) == kIOReturnSuccess,
            interface.pointee.pointee.USBInterfaceClose(interface) == kIOReturnSuccess else {
                return false
        }

        return true
    }

    func updateIsCapable() {
        isCapable = getDataFor(type: UVCRequestCodes.getInfo, length: 1) != 0
    }
}
