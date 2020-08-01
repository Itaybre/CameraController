//
//  BitmapCaptureDeviceProperty.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

class BitmapCaptureDeviceProperty {
    private let control: UVCBitmapControl

    let isCapable: Bool

    var selected: UVCBitmapControl.BitmapValue {
        get {
            return control.current
        }
        set {
            control.current = newValue
        }
    }

    init(_ control: UVCBitmapControl) {
        self.control = control
        isCapable = control.isCapable
        selected = control.current
    }

    func reset() {
        control.current = control.defaultValue
    }

    func write() {
        selected = control.current
    }
}
