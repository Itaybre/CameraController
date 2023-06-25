//
//  AppDelegate.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Cocoa
import SwiftUI
import Sparkle

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarManager: StatusBarManager!

    private let updaterController = SPUStandardUpdaterController(
        startingUpdater: true,
        updaterDelegate: nil,
        userDriverDelegate: nil
    )

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        LetsMove.shared.moveToApplicationsFolderIfNecessary()

        statusBarManager = StatusBarManager()
        WindowManager.shared.showWindow()
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    // MARK: - Check For Updates
    func checkForUpdates() {
        updaterController.checkForUpdates(nil)
    }
}
