//
//  StatusBarManager.swift
//  CameraController
//
//  Created by Itay Brenner on 25/1/22.
//  Copyright © 2022 Itaysoft. All rights reserved.
//

import Foundation
import Cocoa

class StatusBarManager {
    var statusBarItem: NSStatusItem!

    init() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusBarItem.button {
            button.image = NSImage(named: "MenuIcon")
            button.imageScaling = NSImageScaling.scaleProportionallyDown
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(buildMenu),
                                               name: .devicesUpdated,
                                               object: nil)
        buildMenu()
    }

    @objc
    func buildMenu() {
        statusBarItem.menu = MenuBuilder().buildMenu(self)
    }
}

extension StatusBarManager: MenuTarget {
    @objc
    func quit() {
        NSApplication.shared.terminate(self)
    }

    @objc
    func showPanel() {
        WindowManager.shared.showWindow()
        NSApp.activate(ignoringOtherApps: true)
    }

    @objc
    func deviceSelected(_ menuItem: NSMenuItem) {
        DevicesManager.shared.selectedDevice = DevicesManager.shared.devices[menuItem.tag]
        buildMenu()
    }

    @objc
    func profileSelected(_ menuItem: NSMenuItem) {
        guard let device = DevicesManager.shared.selectedDevice,
              menuItem.tag < ProfileManager.shared.profiles.count else {
            return
        }

        let profile = ProfileManager.shared.profiles[menuItem.tag]

        if let settings = profile.settings {
            device.controller?.set(settings)
        } else {
            device.controller?.resetDefault()
        }
    }

    @objc
    func defaultProfileSelected() {
        guard let device = DevicesManager.shared.selectedDevice else {
            return
        }

        device.controller?.resetDefault()
    }
}
