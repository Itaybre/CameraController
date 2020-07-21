//
//  io_service_t+Interface.swift
//  CameraController
//
//  Created by Itay Brenner on 7/20/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

private let kIOCFPlugInInterfaceID: CFUUID =  CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,
                                                                             0xC2, 0x44, 0xE8, 0x58,
                                                                             0x10, 0x9C, 0x11, 0xD4,
                                                                             0x91, 0xD4, 0x00, 0x50,
                                                                             0xE4, 0xC6, 0x42, 0x6F)

typealias PluginInterfacePointer = UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>>

extension io_service_t {
    func ioCreatePluginInterfaceFor(service: CFUUID,
                                    handle: (PluginInterfacePointer) throws -> Void) rethrows {
        var ref: UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>?>?
        var score: Int32 = 0
        guard IOCreatePlugInInterfaceForService(self, service, kIOCFPlugInInterfaceID,
                                                &ref, &score) == kIOReturnSuccess, score == 0 else { return }
        defer { _ = ref?.pointee?.pointee.Release(ref) }
        try ref?.withMemoryRebound(to: UnsafeMutablePointer<IOCFPlugInInterface>.self, capacity: 1, handle)
    }
}
