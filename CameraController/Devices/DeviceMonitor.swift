//
//  DeviceMonitor.swift
//  CameraController
//
//  Created by Itay Brenner on 8/1/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import Combine

class DeviceMonitor {
    private var readTimer: Timer?
    private var writeTimer: Timer?
    private var readInterval: Double = 0
    private var writeInterval: Double = 0
    private var lastDevice: CaptureDevice?
    private var readCancellable: AnyCancellable?
    private var writeCancellable: AnyCancellable?

    init() {
        readCancellable = UserSettings.shared.$readRate.sink { [weak self] (newValue) in
            self?.readInterval = newValue.rawValue
            self?.recreateTimers()
        }

        writeCancellable = UserSettings.shared.$writeRate.sink { [weak self] (newValue) in
            self?.writeInterval = newValue.rawValue
            self?.recreateTimers()
        }
    }

    private func recreateTimers() {
        readTimer?.invalidate()
        writeTimer?.invalidate()

        if readInterval > 0 {
            readTimer = Timer.scheduledTimer(timeInterval: readInterval,
                                             target: self,
                                             selector: #selector(readFromDevice),
                                             userInfo: nil,
                                             repeats: true)
        }

        if writeInterval > 0 {
            writeTimer = Timer.scheduledTimer(timeInterval: writeInterval,
                                             target: self,
                                             selector: #selector(writeToDevice),
                                             userInfo: nil,
                                             repeats: true)
        }
    }

    func updateDevice(_ captureDevice: CaptureDevice?) {
        lastDevice = captureDevice
        recreateTimers()
    }

    @objc
    private func readFromDevice() {
        lastDevice?.readValuesFromDevice()
    }

    @objc
    private func writeToDevice() {
        lastDevice?.writeValuesToDevice()
    }
}
