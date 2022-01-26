//
//  WindowManager.swift
//  CameraController
//
//  Created by Itay Brenner on 25/1/22.
//  Copyright © 2022 Itaysoft. All rights reserved.
//

import Foundation
import SwiftUI

class WindowManager {
    static let shared = WindowManager()

    var window: NSWindow?

    private init() {}

    func showWindow() {
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
        window?.makeKeyAndOrderFront(nil)
    }

    func closeWindow() {
        window?.close()
    }
}
