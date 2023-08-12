//
//  UpdatesSection.swift
//  CameraController
//
//  Created by Itay Brenner on 9/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct UpdatesSection: View {
    @ObservedObject var settings = UserSettings.shared

    var body: some View {
        SectionView {
            SectionTitle(title: "Updates",
                         image: Image(systemName: "icloud"))

            HStack(spacing: 20.0) {
                Text("Check For Updates On Startup")
                Spacer()
                Toggle(isOn: $settings.checkForUpdatesOnStartup)
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
}

#if DEBUG
struct UpdatesSection_Previews: PreviewProvider {
    static var previews: some View {
        UpdatesSection()
    }
}
#endif
