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
    @ObservedObject var settings = UserSettings.shared

    var body: some View {
        HStack {
            VStack {
                Picker(selection: $manager.selectedDevice, label: Text("Camera")) {
                    Text("None").tag(nil as CaptureDevice?)
                    ForEach(manager.devices, id: \.self) { device in
                        Text(device.name).tag(device as CaptureDevice?)
                    }
                }

                if !settings.hideCameraPreview {
                    cameraPreview(captureDevice: $manager.selectedDevice)
                }

                settingsView(captureDevice: $manager.selectedDevice)
                ProfileSelector().frame(width: 400, height: 75)
            }.onAppear {
                DevicesManager.shared.startMonitoring()
            }.onDisappear {
                DevicesManager.shared.stopMonitoring()
            }
        }.padding(.all, 10.0).frame(width: 450)
    }

    func cameraPreview(captureDevice: Binding<CaptureDevice?>) -> AnyView {
        if captureDevice.wrappedValue != nil {
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
