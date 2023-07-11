//
//  ReadWriteSection.swift
//  CameraController
//
//  Created by Itay Brenner on 9/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct ReadWriteSection: View {
    @ObservedObject var settings = UserSettings.shared

    var body: some View {
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
                }.frame(width: 200)
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
                }.frame(width: 200)
            }
        }
    }
}

struct ReadWriteSection_Previews: PreviewProvider {
    static var previews: some View {
        ReadWriteSection()
    }
}
