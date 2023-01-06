//
//  PreferencesView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var settings = UserSettings.shared

    var body: some View {
        VStack(alignment: .leading) {
            applicationSettings()
            readSettings()
            writeSettings()
        }
    }

    fileprivate func applicationSettings() -> some View {
        return GroupBox(label: Text("Application")) {
            HStack {
                VStack(alignment: .leading) {
                    Toggle(isOn: $settings.openAtLogin) {
                        Text("Open at login")
                    }
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Toggle(isOn: $settings.hideCameraPreview) {
                        Text("Hide camera preview")
                    }
                }
                Spacer()
            }
        }
    }

    fileprivate func readSettings() -> some View {
        return GroupBox(label: Text("Read Settings")) {
            HStack {
                VStack(alignment: .leading) {
                    Picker(selection: $settings.readRate, label: Text("")) {
                        Text("Disabled").tag(RefreshSettingsRate.disabled)
                        Text("Every 0.5 Seconds").tag(RefreshSettingsRate.halfSecond)
                        Text("Every 1 Second").tag(RefreshSettingsRate.oneSecond)
                        Text("Every 2 Second").tag(RefreshSettingsRate.twoSeconds)
                    }
                }
                Spacer()
            }
        }
    }

    fileprivate func writeSettings() -> some View {
        GroupBox(label: Text("Push Settings")) {
            HStack {
                VStack(alignment: .leading) {
                    Picker(selection: $settings.writeRate, label: Text("")) {
                        Text("Disabled").tag(RefreshSettingsRate.disabled)
                        Text("Every 0.5 Seconds").tag(RefreshSettingsRate.halfSecond)
                        Text("Every 1 Second").tag(RefreshSettingsRate.oneSecond)
                        Text("Every 2 Second").tag(RefreshSettingsRate.twoSeconds)
                    }
                }
                Spacer()
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
