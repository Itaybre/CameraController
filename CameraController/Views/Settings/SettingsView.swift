//
//  SettingsView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    @Binding var captureDevice: CaptureDevice?
    @State var currentView: Int = 1

    var body: some View {
        GroupBox(label: Text("Settings")) {
            if captureDevice?.uvcDevice == nil {
                HStack {
                    Text("This device cannot be configured")
                    Spacer()
                }
            } else {
                VStack {
                    Picker(selection: $currentView.animation(.linear), label: EmptyView()) {
                        Text("Basic").tag(1)
                        Text("Advanced").tag(2)
                        Text("Preferences").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300)

                    if currentView == 1 {
                        BasicSettings(controller: (captureDevice?.controller!)!).animation(.linear)
                    } else if currentView == 2 {
                        AdvancedView(controller: (captureDevice?.controller!)!).animation(.linear)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(captureDevice: .constant(nil))
    }
}
