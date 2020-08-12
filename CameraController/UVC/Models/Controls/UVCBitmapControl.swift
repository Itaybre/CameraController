//
//  UVCBitmapControl.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

class UVCBitmapControl: UVCControl {
    enum BitmapValue: Int {
        case manual = 1
        case auto = 2
        case shutterPriority = 4
        case aperturePriority = 8
    }

    var defaultValue: BitmapValue = .manual

    var current: BitmapValue {
        get {
            return internalCurrent
        }
        set {
            if setData(value: newValue.rawValue, length: uvcSize) {
                internalCurrent = newValue
            }
        }
    }

    var internalCurrent: BitmapValue = .manual

    override init(_ interface: USBInterfacePointer, _ uvcSize: Int,
                  _ uvcSelector: Selector, _ uvcUnit: Int, _ uvcInterface: Int) {
        super.init(interface, uvcSize, uvcSelector, uvcUnit, uvcInterface)
        configure()
    }

    private func configure() {
        updateIsCapable()

        if isCapable {
            updateCurrent()
            updateDefault()
        }
    }

    func updateCurrent() {
        let value = getDataFor(type: .getCurrent, length: 1)

        if let parsed = BitmapValue(rawValue: value) {
            internalCurrent = parsed
        } else {
            isCapable = false
        }
    }

    func updateDefault() {
        let value = getDataFor(type: .getDefault, length: 1)

        if let parsed = BitmapValue(rawValue: value) {
            defaultValue = parsed
        } else {
            isCapable = false
        }
    }
}
