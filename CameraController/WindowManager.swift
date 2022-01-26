//
//  WindowManager.swift
//  CameraController
//
//  Created by Itay Brenner on 25/1/22.
//  Copyright © 2022 Itaysoft. All rights reserved.
//

import Foundation
import SwiftUI

class WindowManager: NSObject {
    static let shared = WindowManager()

    var window: NSWindow?

    override private init() {
        super.init()
    }

    func showWindow() {
        NotificationCenter.default.post(name: .windowOpen, object: nil)
        guard window?.isVisible != true else {
            window?.makeKeyAndOrderFront(nil)
            return
        }

        let contentView = ContentView()

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window?.center()
        window?.setFrameAutosaveName("Main Window")
        window?.contentView = NSHostingView(rootView: contentView)
        window?.isReleasedWhenClosed = false
        window?.delegate = self
        window?.makeKeyAndOrderFront(nil)
    }

    func closeWindow() {
        window?.close()
    }
}

extension WindowManager: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NotificationCenter.default.post(name: .windowClose, object: nil)
    }
}
