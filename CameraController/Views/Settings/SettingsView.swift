//
//  SettingsView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Binding var captureDevice: CaptureDevice?
    @Binding var currentSection: Int?

    var body: some View {
        VStack {
            if currentSection == nil {
                Spacer()
                    .frame(height: Constants.Style.padding)
            } else {
                contentView()
                    .frame(maxWidth: .infinity)
                    .padding(.all, Constants.Style.padding)
            }
        }
        .transition(.opacity.animation(.easeOut(duration: 0.25)))
        .animation(nil)
        .id(currentSection)
    }

    @ViewBuilder
    fileprivate func contentView() -> some View {
        if currentSection == 3 {
            PreferencesView()
        } else if let controller = captureDevice?.controller {
            if currentSection == 0 {
                BasicSettings(controller: controller)
            } else if currentSection == 1 {
                AdvancedView(controller: controller)
            } else if currentSection == 2 {
                ProfilesView()
            }
        } else {
            UnsupportedView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            captureDevice: .constant(nil),
            currentSection: .constant(nil)
        )
    }
}
