//
//  PreferencesView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        VStack(spacing: Constants.Style.controlsSpacing) {
            ApplicationSection()
            CameraSection()
            PreviewSection()
            ReadWriteSection()
            UpdatesSection()
            QuitButton()

            Spacer()
                .frame(height: 8)
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
