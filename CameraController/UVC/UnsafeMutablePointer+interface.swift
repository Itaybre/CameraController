//
//  UnsafeMutablePointer+interface.swift
//  CameraController
//
//  Created by Itay Brenner on 7/20/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

extension UnsafeMutablePointer where Pointee == UnsafeMutablePointer<IOCFPlugInInterface> {
    func getInterface<T>(uuid: CFUUID) throws -> UnsafeMutablePointer<T> {
        var ref: LPVOID?
        guard pointee.pointee.QueryInterface(self, CFUUIDGetUUIDBytes(uuid), &ref) == kIOReturnSuccess,
            let result: UnsafeMutablePointer<T> = ref?.assumingMemoryBound(to: T.self) else {
                throw NSError(domain: #function, code: #line, userInfo: nil)
        }

        return result
    }
}

extension UnsafeMutablePointer where Pointee == UnsafeMutablePointer<IOUSBDeviceInterface> {
    func iterate(interfaceRequest: IOUSBFindInterfaceRequest,
                 handle: (UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>>) throws -> Void) rethrows {
        var iterator: io_iterator_t = 0
        let mutatingPointer = UnsafeMutablePointer<IOUSBFindInterfaceRequest>(mutating: [interfaceRequest])
        guard pointee.pointee.CreateInterfaceIterator(self, mutatingPointer, &iterator) == kIOReturnSuccess else {
                                                        return
        }
        defer {
            let code: kern_return_t = IOObjectRelease(iterator)
            assert( code == kIOReturnSuccess )
        }
        while true {
            let object: io_service_t = IOIteratorNext(iterator)
            defer {
                let code: kern_return_t = IOObjectRelease(object)
                assert( code == kIOReturnSuccess )
            }
            guard 0 < object else { break }
            try object.ioCreatePluginInterfaceFor(service: kIOUSBInterfaceUserClientTypeID,
                                                  handle: handle)
        }
    }
}

private let kIOUSBInterfaceUserClientTypeID: CFUUID = CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,
                                                                                     0x2d, 0x97, 0x86, 0xc6,
                                                                                     0x9e, 0xf3, 0x11, 0xD4,
                                                                                     0xad, 0x51, 0x00, 0x0a,
                                                                                     0x27, 0x05, 0x28, 0x61)
