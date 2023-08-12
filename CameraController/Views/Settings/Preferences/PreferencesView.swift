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
        }
        .padding(.top, 2)
        .padding(.bottom, Constants.Style.topSpacing)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
