//
//  ContentView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI
import Combine
import AVFoundation

struct ContentView: View {
    @ObservedObject var manager = DevicesManager.shared
    @State var shouldShowPreview = false

    let willShowPublisher = NotificationCenter.default.publisher(for: NSPopover.willShowNotification)
    let didClosePublisher = NotificationCenter.default.publisher(for: NSPopover.didCloseNotification)

    var body: some View {
        HStack {
            VStack {
                Picker(selection: $manager.selectedDevice, label: Text("Camera")) {
                    ForEach(manager.devices, id: \.self) { device in
                        Text(device.name).tag(device as CaptureDevice?)
                    }
                }
                cameraPreview(captureDevice: $manager.selectedDevice)
                settingsView(captureDevice: $manager.selectedDevice)
                ProfileSelector().frame(width: 400, height: 75)
            }
            .onReceive(willShowPublisher) { _ in
                DevicesManager.shared.startMonitoring()
                self.shouldShowPreview = true
            }
            .onReceive(didClosePublisher) { _ in
                DevicesManager.shared.stopMonitoring()
                self.shouldShowPreview = false
            }
        }.padding(.all, 10.0).frame(width: 450)
    }

    func cameraPreview(captureDevice: Binding<CaptureDevice?>) -> AnyView {
        if captureDevice.wrappedValue != nil && shouldShowPreview {
            return AnyView(CameraPreview(captureDevice: captureDevice)
                .frame(width: 400, height: 225))
        } else {
            return AnyView(Image("video.slash")
                .frame(width: 400, height: 225)
                .background(Color.gray))
        }
    }

    func settingsView(captureDevice: Binding<CaptureDevice?>) -> some View {
        if captureDevice.wrappedValue != nil {
            return AnyView(SettingsView(captureDevice: captureDevice))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
