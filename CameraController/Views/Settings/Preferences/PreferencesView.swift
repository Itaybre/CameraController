//
//  PreferencesView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var manager = DevicesManager.shared
    @ObservedObject var settings = UserSettings.shared

    var body: some View {
        VStack(alignment: .leading) {
            applicationSettings()
            cameraSettings()
            readWriteSettings()
            updatesSettings()
            quitButton()
        }
    }

    @ViewBuilder
    private func applicationSettings() -> some View {
        SectionView {
            SectionTitle(title: "Application",
                         image: Image(systemName: "flag"))

            HStack(spacing: 20.0) {
                Text("Open at login")
                Spacer()
                Toggle(isOn: $settings.openAtLogin) {}
                    .toggleStyle(SwitchToggleStyle(tint: Constants.Colors.accentColor))
            }
            HStack(spacing: 20.0) {
                Text("Preview Size")
                Spacer()
                Picker(selection: $settings.cameraPreviewSize, label: Text("")) {
                    Text("Disabled").tag(PreviewSizeSettings.disabled)
                    Text("Small").tag(PreviewSizeSettings.small)
                    Text("Medium").tag(PreviewSizeSettings.medium)
                    Text("Large").tag(PreviewSizeSettings.large)
                    Text("Extra Large").tag(PreviewSizeSettings.extraLarge)
                }
                .frame(width: 100)
            }
        }
    }

    @ViewBuilder
    private func cameraSettings() -> some View {
        SectionView {
            SectionTitle(title: "Camera",
                         image: Image(systemName: "web.camera"))

            HStack(spacing: 20.0) {
                Text("Camera")
                Spacer()
                Picker(selection: $manager.selectedDevice, label: Text("")) {
                    Text("None").tag(nil as CaptureDevice?)
                    ForEach(manager.devices, id: \.self) { device in
                        Text(device.name).tag(device as CaptureDevice?)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func readWriteSettings() -> some View {
        SectionView {
            SectionTitle(title: "Read / Write settings from device",
                         image: Image(systemName: "arrow.left.arrow.right"))

            HStack(spacing: 20.0) {
                Text("Read")
                    .help("CameraController will read the configuration from the camera every X amount of time.")
                Spacer()
                Picker(selection: $settings.readRate, label: Text("")) {
                    Text("Disabled").tag(RefreshSettingsRate.disabled)
                    Text("Every 0.5 Seconds").tag(RefreshSettingsRate.halfSecond)
                    Text("Every 1 Second").tag(RefreshSettingsRate.oneSecond)
                    Text("Every 2 Second").tag(RefreshSettingsRate.twoSeconds)
                }.frame(width: 100)
            }
            HStack(spacing: 20.0) {
                Text("Write")
                    .help("CameraController will write the configuration to the camera every X amount of time.")
                Spacer()
                Picker(selection: $settings.writeRate, label: Text("")) {
                    Text("Disabled").tag(RefreshSettingsRate.disabled)
                    Text("Every 0.5 Seconds").tag(RefreshSettingsRate.halfSecond)
                    Text("Every 1 Second").tag(RefreshSettingsRate.oneSecond)
                    Text("Every 2 Second").tag(RefreshSettingsRate.twoSeconds)
                }.frame(width: 100)
            }
        }
    }

    @ViewBuilder
    private func updatesSettings() -> some View {
        SectionView {
            SectionTitle(title: "Updates",
                         image: Image(systemName: "icloud"))

            HStack(spacing: 20.0) {
                Text("Check For Updates On Startup")
                Spacer()
                Toggle(isOn: $settings.checkForUpdatesOnStartup) {}
                    .toggleStyle(SwitchToggleStyle(tint: Constants.Colors.accentColor))
            }
            HStack(spacing: 20.0) {
                Spacer()
                Button("Check For Updates Now") {
                    guard let delegate = NSApplication.shared.delegate as? AppDelegate else {
                        return
                    }
                    delegate.checkForUpdates()
                }
                .buttonStyle(.plain)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Constants.Colors.sliderBackground)
                .clipShape(Capsule())
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func quitButton() -> some View {
        HStack {
            Spacer()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.plain)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Constants.Colors.sliderBackground)
            .clipShape(Capsule())

            Spacer()
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
