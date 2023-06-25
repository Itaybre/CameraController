//
//  io_service_t+Interface.swift
//  CameraController
//
//  Created by Itay Brenner on 7/20/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

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
