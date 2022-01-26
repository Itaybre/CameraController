//
//  MenuBuilder.swift
//  CameraController
//
//  Created by Itay Brenner on 26/1/22.
//  Copyright © 2022 Itaysoft. All rights reserved.
//

import Foundation
import Cocoa

@objc
protocol MenuTarget: AnyObject {
    @objc func quit()
    @objc func showPanel()
    @objc func deviceSelected(_ menuItem: NSMenuItem)
}

class MenuBuilder: NSObject {
    func buildMenu(_ target: MenuTarget) -> NSMenu {
        let mainMenu = NSMenu()

        mainMenu.addItem(buildShowPanelItem(target))
        mainMenu.addItem(NSMenuItem.separator())

        buildCameraSection(target).forEach { menuItem in
            mainMenu.addItem(menuItem)
        }

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
        let showItem = NSMenuItem()
        showItem.title = "Show Camera Settings Panel"
        showItem.target = target
        showItem.action = #selector(MenuTarget.showPanel)

        return showItem
    }

    func buildCameraSection(_ target: MenuTarget) -> [NSMenuItem] {
        var items: [NSMenuItem] = []

        let titleItem = NSMenuItem()
        titleItem.title = "Camera"
        titleItem.target = nil
        items.append(titleItem)

        for (index, device) in DevicesManager.shared.devices.enumerated() {
            let deviceItem = NSMenuItem()
            deviceItem.title = device.name
            deviceItem.target = target
            deviceItem.action = #selector(MenuTarget.deviceSelected(_:))
            deviceItem.indentationLevel = 1
            deviceItem.tag = index
            deviceItem.state = DevicesManager.shared.selectedDevice == device ? .on : .off

            items.append(deviceItem)
        }

        return items
    }
}
