//
//  MultipleCaptureDeviceProperty.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

class MultipleCaptureDeviceProperty {
    private let control: UVCMultipleIntControl

    var sliderValue1: Float {
        get {
            return Float(control.current1)
        }
        set {
            if sliderValue1 != newValue {
                control.current1 = Int(newValue)
            }
        }
    }

    var sliderValue2: Float {
        get {
            return Float(control.current2)
        }
        set {
            if sliderValue2 != newValue {
                control.current2 = Int(newValue)
            }
        }
    }

    let isCapable: Bool
    let minimum1: Float
    let minimum2: Float
    let maximum1: Float
    let maximum2: Float
    let resolution1: Float
    let resolution2: Float

    init(_ control: UVCMultipleIntControl) {
        self.control = control
        isCapable = control.isCapable
        minimum1 = Float(control.minimum1)
        minimum2 = Float(control.minimum2)
        maximum1 = Float(control.maximum1)
        maximum2 = Float(control.maximum2)
        resolution1 = Float(control.resolution1)
        resolution2 = Float(control.resolution2)
        sliderValue1 = Float(control.current1)
        sliderValue2 = Float(control.current2)
    }

    func reset() {
        control.current1 = control.defaultValue1
        control.current2 = control.defaultValue2
    }

    func write() {
        sliderValue1 = Float(control.current1)
        sliderValue2 = Float(control.current2)
    }
}
