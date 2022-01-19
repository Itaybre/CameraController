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
                    Text("Vendor Specific").tag(3)
                    Text("Preferences").tag(4)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)

                contentView()
            }
        }
    }

    fileprivate func basicVew() -> AnyView {
        if let controller = captureDevice?.controller {
            return AnyView(BasicSettings(controller: controller))
        } else {
            return AnyView(DisabledBasicSettings())
        }
    }

    fileprivate func advancedView() -> AnyView {
        if let controller = captureDevice?.controller {
            return AnyView(AdvancedView(controller: controller))
        } else {
            return AnyView(DisabledAdvancedView())
        }
    }

    fileprivate func contentView() -> AnyView {
        if currentView == 1 {
            return basicVew()
        } else if currentView == 2 {
            return advancedView()
        } else if currentView == 3 {
            return AnyView(EmptyView())
        } else {
            return AnyView(PreferencesView())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(captureDevice: .constant(nil))
    }
}
