//
//  PreferencesView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI
import Combine
import ServiceManagement

class UserSettings: ObservableObject {
    @Published var openAtLogin: Bool {
        didSet {
            let success = SMLoginItemSetEnabled("com.itaysoft.CameraController.Helper" as CFString, openAtLogin)
            if success {
                UserDefaults.standard.set(openAtLogin, forKey: "login")
            }
        }
    }

    init() {
        self.openAtLogin = UserDefaults.standard.bool(forKey: "login")

    }
}

struct PreferencesView: View {
    @ObservedObject var settings = UserSettings()

    var body: some View {
        VStack(alignment: .leading) {
            GroupBox(label: Text("Application")) {
                HStack {
                    VStack(alignment: .leading) {
                        Toggle(isOn: $settings.openAtLogin) {
                            Text("Open at login")
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
