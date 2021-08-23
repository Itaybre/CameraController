//
//  IOUSBConfigurationDescriptorPtr+UVC.swift
//  CameraController
//
//  Created by Itay Brenner on 7/20/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import IOKit

typealias InterfaceDescriptorPointer = UnsafeMutablePointer<UVC_InterfaceDescriptorHdr>
typealias ProcessingUnitDescriptorPointer = UnsafeMutablePointer<UVC_ProcessingUnitDescriptor>
typealias CameraTerminalDescriptorPointer = UnsafeMutablePointer<UVC_CameraTerminalDescriptor>

extension IOUSBConfigurationDescriptorPtr {
    func proccessDescriptor() -> UVCDescriptor {
        var processingUnitID = -1
        var cameraTerminalID = -1
        var interfaceID = -1

        let remaining = self.pointee.wTotalLength - UInt16(self.pointee.bLength)
        var pointer = UnsafeMutablePointer<UInt8>(OpaquePointer(self))
        pointer = pointer.advanced(by: Int(self.pointee.bLength))

        browseDescriptor(remaining, pointer, &processingUnitID, &cameraTerminalID, &interfaceID)

        return UVCDescriptor(processingUnitID: processingUnitID,
                             cameraTerminalID: cameraTerminalID,
                             interfaceID: interfaceID)
    }

    fileprivate func browseDescriptor(_ memory: UInt16, _ pointer: UnsafeMutablePointer<UInt8>,
                                      _ processingUnitID: inout Int, _ cameraTerminalID: inout Int,
                                      _ interfaceID: inout Int) {
        var remaining = memory
        var currentPointer = pointer

        while remaining > 0 {
            var descriptorPointer = InterfaceDescriptorPointer(OpaquePointer(currentPointer))

            if descriptorPointer.pointee.bDescriptorType == kUSBInterfaceDesc {
                let intDesc = UnsafeMutablePointer<IOUSBInterfaceDescriptor>(OpaquePointer(descriptorPointer))
                if !(intDesc.pointee.bInterfaceClass == UVCConstants.classVideo
                    && intDesc.pointee.bInterfaceSubClass == UVCConstants.subclassVideoControl) {

                    currentPointer = currentPointer.advanced(by: Int(intDesc.pointee.bLength))
                    continue
                }

                currentPointer = currentPointer.advanced(by: Int(intDesc.pointee.bLength))
                descriptorPointer = InterfaceDescriptorPointer(OpaquePointer(currentPointer))

                if descriptorPointer.pointee.bDescriptorType != UVCConstants.descriptorTypeInterface {
                    break
                }

                let internalDescriptor = UnsafeMutablePointer<UVC_VCHeaderDescriptor>(OpaquePointer(descriptorPointer))
                if internalDescriptor.pointee.bDescriptorSubType == UVCConstants.subclassVideoControl {
                    let littleEndian = Int(internalDescriptor.pointee.wTotalLength).littleEndian
                    internalDescriptor.pointee.wTotalLength = UInt16(littleEndian)

                    remaining -= internalDescriptor.pointee.wTotalLength
                    currentPointer = currentPointer.advanced(by: Int(internalDescriptor.pointee.bLength))
                    var remainingMemory = internalDescriptor.pointee.wTotalLength
                        - UInt16(internalDescriptor.pointee.bLength)

                    while remainingMemory > 0 {
                        descriptorPointer = InterfaceDescriptorPointer(OpaquePointer(currentPointer))
                        if descriptorPointer.pointee.bDescriptorType != UVCConstants.descriptorTypeInterface {
                            break
                        }

                        getDeviceId(descriptorPointer, currentPointer, &processingUnitID, &cameraTerminalID)
                        interfaceID = Int(intDesc.pointee.bInterfaceNumber)
                        
                        if interfaceID != -1 && processingUnitID != -1 && cameraTerminalID != -1 {
                            // Found all necessary data, exit
                            // Fix for WB7022 Camera
                            return
                        }

                        remainingMemory -= UInt16(descriptorPointer.pointee.bLength)
                        currentPointer = currentPointer.advanced(by: Int(descriptorPointer.pointee.bLength))
                    }
                } else {
                    remaining -= UInt16(descriptorPointer.pointee.bLength)
                    currentPointer = currentPointer.advanced(by: Int(descriptorPointer.pointee.bLength))
                }
                break
            } else {
                remaining -= UInt16(descriptorPointer.pointee.bLength)
                currentPointer = currentPointer.advanced(by: Int(descriptorPointer.pointee.bLength))
            }
        }
    }

    fileprivate func getDeviceId(_ descriptorPointer: InterfaceDescriptorPointer,
                                 _ currentPointer: UnsafeMutablePointer<UInt8>,
                                 _ processingUnitID: inout Int, _ cameraTerminalID: inout Int) {
        let unitType = UVCConstants.DescriptorSubtype(rawValue: descriptorPointer.pointee.bDescriptorSubType)
        switch unitType {
        case .processingUnit:
            let puPointer = ProcessingUnitDescriptorPointer(OpaquePointer(currentPointer))
            processingUnitID = Int(puPointer.pointee.bUnitID)
        case .inputTerminal:
            let ctPointer = CameraTerminalDescriptorPointer(OpaquePointer(currentPointer))
            cameraTerminalID = Int(ctPointer.pointee.bTerminalID)
        case .none:
            break
        case .selectorUnit:
            break
        case .extensionUnit:
            break
        }
    }
}
