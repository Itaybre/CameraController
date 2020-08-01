//
//  IntCaptureDeviceProperty.swift
//  CameraController
//
//  Created by Itay Brenner on 7/24/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

class NumberCaptureDeviceProperty {
    private let control: UVCIntControl

    var sliderValue: Float {
        get {
            return Float(control.current)
        }
        set {
            if sliderValue != newValue {
                control.current = Int(newValue)
            }
        }
    }

    let isCapable: Bool
    let minimum: Float
    let maximum: Float
    let resolution: Float

    init(_ control: UVCIntControl) {
        self.control = control
        isCapable = control.isCapable
        minimum = Float(control.minimum)
        maximum = Float(control.maximum)
        resolution = Float(control.resolution)
        sliderValue = Float(control.current)
    }

    func reset() {
        control.current = control.defaultValue
    }

    func update() {
        control.updateCurrent()
    }

    func write() {
        sliderValue = Float(control.current)
    }
}
