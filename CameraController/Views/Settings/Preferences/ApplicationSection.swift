//
//  ApplicationSection.swift
//  CameraController
//
//  Created by Itay Brenner on 9/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct ApplicationSection: View {
    @ObservedObject var settings = UserSettings.shared

    var body: some View {
        SectionView {
            SectionTitle(title: "Application",
                         image: Image(systemName: "flag"))

            HStack(spacing: 20.0) {
                Text("Open at login")
                Spacer()
                Toggle(isOn: $settings.openAtLogin)
                    .toggleStyle(SwitchToggleStyle(tint: Constants.Colors.accentColor))
            }
        }
    }
}

#if DEBUG
struct ApplicationSection_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationSection()
    }
}
#endif
