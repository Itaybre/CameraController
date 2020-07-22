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

    @State var selectedDevice: AVCaptureDevice?
    @ObservedObject var manager = DevicesManager.shared

    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            VStack {
                Spacer().frame(height: 10)
                Picker(selection: $selectedDevice.animation(.linear), label: Text("Camera")) {
                    ForEach(manager.devices, id: \.self) { device in
                        Text(device.localizedName).tag(device as AVCaptureDevice?)
                    }
                }
                Text("Selected Device: \(selectedDevice?.localizedName ?? "No Device")")
            }.onAppear {
                DevicesManager.shared.startMonitoring()
            }.onDisappear {
                DevicesManager.shared.stopMonitoring()
            }
            Spacer().frame(width: 10)
        }.frame(width: 450)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
