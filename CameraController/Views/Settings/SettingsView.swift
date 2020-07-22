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
    @Binding var device: AVCaptureDevice?
    @State var currentView: Int = 1

    var body: some View {
        GroupBox(label: Text("Settings")) {
            if device == nil {
                EmptyView()
            } else {
                Picker(selection: $currentView.animation(.linear), label: EmptyView()) {
                    Text("Basic").tag(1)
                    Text("Advanced").tag(2)
                    Text("Preferences").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)

                if currentView == 1 {
                    BasicSettings().animation(.linear)
                }
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
