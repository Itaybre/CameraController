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
            VStack {
                Picker(selection: $currentView.animation(.linear), label: EmptyView()) {
                    Text("Basic").tag(1)
                    Text("Advanced").tag(2)
                    Text("Preferences").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)

                if currentView == 1 {
                    basicVew()
                } else if currentView == 2 {
                    advancedView()
                } else {
                    PreferencesView()
                }
            }
        }
    }

    func basicVew() -> AnyView {
        if let controller = captureDevice?.controller {
            return AnyView(BasicSettings(controller: controller))
        } else {
            return AnyView(DisabledBasicSettings())
        }
    }

    func advancedView() -> AnyView {
        if let controller = captureDevice?.controller {
            return AnyView(AdvancedView(controller: controller))
        } else {
            return AnyView(DisabledAdvancedView())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(captureDevice: .constant(nil))
    }
}
