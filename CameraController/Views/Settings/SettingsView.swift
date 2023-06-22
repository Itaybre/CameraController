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

                contentView()
            }
        }
    }

    @ViewBuilder
    private func basicVew() -> some View {
        if let controller = captureDevice?.controller {
            BasicSettings(controller: controller)
        } else {
            DisabledBasicSettings()
        }
    }

    @ViewBuilder
    private func advancedView() -> some View {
        if let controller = captureDevice?.controller {
            AdvancedView(controller: controller)
        } else {
            DisabledAdvancedView()
        }
    }

    @ViewBuilder
    private func contentView() -> some View {
        if currentView == 1 {
            basicVew()
        } else if currentView == 2 {
            advancedView()
        } else {
            PreferencesView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(captureDevice: .constant(nil))
    }
}
