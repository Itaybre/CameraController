//
//  AVCaptureDevice+USB.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import AVFoundation
import IOKit.usb

private let kIOUSBDeviceUserClientTypeID: CFUUID = CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,
                                                                                  0x9d, 0xc7, 0xb7, 0x80,
                                                                                  0x9e, 0xc0, 0x11, 0xD4,
                                                                                  0xa5, 0x4f, 0x00, 0x0a,
                                                                                  0x27, 0x05, 0x28, 0x61)
private let kIOUSBDeviceInterfaceID: CFUUID =  CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,
                                                                              0x5c, 0x81, 0x87, 0xd0,
                                                                              0x9e, 0xf3, 0x11, 0xD4,
                                                                              0x8b, 0x45, 0x00, 0x0a,
                                                                              0x27, 0x05, 0x28, 0x61)
private let kIOUSBInterfaceInterfaceID: CFUUID =  CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,
                                                                                 0x73, 0xc9, 0x7a, 0xe8,
                                                                                 0x9e, 0xf3, 0x11, 0xD4,
                                                                                 0xb1, 0xd0, 0x00, 0x0a,
                                                                                 0x27, 0x05, 0x28, 0x61)

typealias DeviceInterfacePointer = UnsafeMutablePointer<UnsafeMutablePointer<IOUSBDeviceInterface>>

extension AVCaptureDevice {

    private func getIOService() throws -> io_service_t {
        var camera: io_service_t = 0
        let cameraInformation = try self.modelID.extractCameraInformation()
        let dictionary: NSMutableDictionary = IOServiceMatching("IOUSBDevice") as NSMutableDictionary
        dictionary["idVendor"] = cameraInformation.vendorId
        dictionary["idProduct"] = cameraInformation.productId

        // adding other keys to this dictionary like kUSBProductString, kUSBVendorString, etc don't
        // seem to have any affect on using IOServiceGetMatchingService to get the correct camera,
        // so we instead get an iterator for the matching services based on idVendor and idProduct
        // and fetch their property dicts and then match against the more specific values

        var iter: io_iterator_t = 0
        if IOServiceGetMatchingServices(kIOMasterPortDefault, dictionary, &iter) == kIOReturnSuccess {
            var cameraCandidate: io_service_t
            cameraCandidate = IOIteratorNext(iter)
            while cameraCandidate != 0 {
                var propsRef: Unmanaged<CFMutableDictionary>?

                if IORegistryEntryCreateCFProperties(
                    cameraCandidate,
                    &propsRef,
                    kCFAllocatorDefault,
                    0) == kIOReturnSuccess {
                    if let properties = propsRef?.takeRetainedValue() {

                        // these are common keys that might have the device name stored in the propery dictionary
                        let keysToTry: [String] = [
                            "kUSBProductString",
                            "kUSBVendorString",
                            "USB Product Name",
                            "USB Vendor Name"
                        ]

                        var found: Bool = false
                        for key in keysToTry {
                            if let cameraName = (properties as NSDictionary)[key] as? String {
                                if cameraName == self.localizedName {
                                    // we have a match, use this as the camera
                                    camera = cameraCandidate
                                    found = true
                                    // break out of `for key in keysToTry`
                                    break
                                }
                            }
                        }
                        if found {
                            // break out of `while (cameraCandidate != 0)`
                            break
                        }
                    }
                }
                cameraCandidate = IOIteratorNext(iter)
            }
        }

        // if we haven't found a camera after looping through the iterator, fallback on GetMatchingService method
        if camera == 0 {
            camera = IOServiceGetMatchingService(kIOMasterPortDefault, dictionary)
        }

        return camera
    }

    func usbDevice() throws -> USBDevice {

        let camera = try self.getIOService()
        defer {
            let code: kern_return_t = IOObjectRelease(camera)
            assert( code == kIOReturnSuccess )
        }
        var interfaceRef: UnsafeMutablePointer<UnsafeMutablePointer<IOUSBInterfaceInterface190>>?
        var configDesc: IOUSBConfigurationDescriptorPtr?
        try camera.ioCreatePluginInterfaceFor(service: kIOUSBDeviceUserClientTypeID) {
            let deviceInterface: DeviceInterfacePointer = try $0.getInterface(uuid: kIOUSBDeviceInterfaceID)
            defer { _ = deviceInterface.pointee.pointee.Release(deviceInterface) }
            let interfaceRequest = IOUSBFindInterfaceRequest(bInterfaceClass: UVCConstants.classVideo,
                                                             bInterfaceSubClass: UVCConstants.subclassVideoControl,
                                                             bInterfaceProtocol: UInt16(kIOUSBFindInterfaceDontCare),
                                                             bAlternateSetting: UInt16(kIOUSBFindInterfaceDontCare))
            try deviceInterface.iterate(interfaceRequest: interfaceRequest) {
                interfaceRef = try $0.getInterface(uuid: kIOUSBInterfaceInterfaceID)
            }

            var returnCode: Int32 = 0
            var numConfig: UInt8 = 0
            returnCode = deviceInterface.pointee.pointee.GetNumberOfConfigurations(deviceInterface, &numConfig)
            if returnCode != kIOReturnSuccess {
                print("unable to get number of configurations")
                return
            }

            returnCode = deviceInterface.pointee.pointee.GetConfigurationDescriptorPtr(deviceInterface, 0, &configDesc)
            if returnCode != kIOReturnSuccess {
                print("unable to get config description for config 0 (index)")
                return
            }
        }
        guard interfaceRef != nil else { throw NSError(domain: #function, code: #line, userInfo: nil) }

        let descriptor = configDesc!.proccessDescriptor()

        return USBDevice(interface: interfaceRef.unsafelyUnwrapped,
                         descriptor: descriptor)
    }
}
