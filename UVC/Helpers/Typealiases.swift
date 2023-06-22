//
//  Typealiases.swift
//  UVC
//
//  Created by Itay Brenner on 22/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import Foundation

typealias DeviceInterfacePointer = UnsafeMutablePointer<UnsafeMutablePointer<IOUSBDeviceInterface>>
typealias PluginInterfacePointer = UnsafeMutablePointer<UnsafeMutablePointer<IOCFPlugInInterface>>
typealias InterfaceDescriptorPointer = UnsafeMutablePointer<UVC_InterfaceDescriptorHdr>
typealias ProcessingUnitDescriptorPointer = UnsafeMutablePointer<UVC_ProcessingUnitDescriptor>
typealias CameraTerminalDescriptorPointer = UnsafeMutablePointer<UVC_CameraTerminalDescriptor>
