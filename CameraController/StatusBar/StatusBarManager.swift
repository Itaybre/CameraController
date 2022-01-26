//
//  StatusBarManager.swift
//  CameraController
//
//  Created by Itay Brenner on 25/1/22.
//  Copyright © 2022 Itaysoft. All rights reserved.
//

import Foundation
import Cocoa

@objc
protocol MenuTarget: AnyObject {
    @objc func quit()
    @objc func showPanel()
}

class StatusBarManager {
    var statusBarItem: NSStatusItem!

    init() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusBarItem.button {
            button.image = NSImage(named: "MenuIcon")
            button.imageScaling = NSImageScaling.scaleProportionallyDown
        }

        buildMenu()
    }

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
}

class MenuBuilder: NSObject {
    func buildMenu(_ target: MenuTarget) -> NSMenu {
        let mainMenu = NSMenu()

        mainMenu.addItem(buildShowPanelItem(target))
        mainMenu.addItem(NSMenuItem.separator())
        mainMenu.addItem(buildCloseItem(target))

        return mainMenu
    }

    func buildCloseItem(_ target: MenuTarget) -> NSMenuItem {
        let closeItem = NSMenuItem()
        closeItem.title = "Quit"
        closeItem.target = target
        closeItem.action = #selector(MenuTarget.quit)

        return closeItem
    }
    
    func buildShowPanelItem(_ target: MenuTarget) -> NSMenuItem {
        let closeItem = NSMenuItem()
        closeItem.title = "Show Camera Settings Panel"
        closeItem.target = target
        closeItem.action = #selector(MenuTarget.showPanel)

        return closeItem
    }
}
