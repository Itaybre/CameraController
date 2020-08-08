//
//  ProfileSelector.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileSelector: View {
    @ObservedObject var devicesManager = DevicesManager.shared
    @ObservedObject var profileManager = ProfileManager.shared
    @State var selectedProfile: Profile?
    @State var showAddProfile: Bool = false
    @State var profileName: String = ""

    private let buttonWidth: CGFloat = 110

    var body: some View {
        GroupBox(label: Text("Profile")) {
            VStack {
                HStack {
                    Button(action: {
                        self.showAddProfile = true
                    }) {
                        Text("Save Profile")
                            .frame(width: self.buttonWidth)
                    }.disabled(!canCreateProfile())

                    Button(action: {}) {
                        Text("Update Profile")
                        .frame(width: self.buttonWidth)
                    }.disabled(!canCreateProfile() || (selectedProfile == nil || selectedProfile?.isDefault ?? false))

                    Button(action: {
                        self.deleteProfile()
                    }) {
                        Text("Delete Profile")
                        .frame(width: self.buttonWidth)
                    }.disabled(selectedProfile == nil || selectedProfile?.isDefault ?? false)
                }

                HStack {
                    Picker(selection: $selectedProfile, label: EmptyView()) {
                        Text("Camera Default").tag(Profile() as Profile?)
                        VStack {Divider().padding(.leading)}
                        ForEach(profileManager.profiles, id: \.self) { profile in
                            Text(profile.name).tag(profile as Profile?)
                        }
                    }

                    Button(action: {
                        self.applyProfile()
                    }) {
                        Text("Apply")
                    }
                }
            }
        }.sheet(isPresented: $showAddProfile) {
            VStack {
                Text("Please set a name for the new profile")
                TextField("Profile Name", text: self.$profileName)

                HStack {
                    Spacer()
                    Button(action: {
                        self.addNewProfile()
                    }) {
                        Text("Save")
                    }
                    Button(action: {
                        self.showAddProfile = false
                    }) {
                        Text("Cancel")
                    }
                }
            }.padding()
        }
        .disabled(!(DevicesManager.shared.selectedDevice?.isConfigurable() ?? false))
    }

    private func applyProfile() {
        guard let profile = selectedProfile,
            let device = DevicesManager.shared.selectedDevice else {
            return
        }

        if let settings = profile.settings {
            device.controller?.set(settings)
        } else {
            device.controller?.resetDefault()
        }
    }

    private func addNewProfile() {
        guard let device = DevicesManager.shared.selectedDevice,
            let controller = device.controller else {
            return
        }

        profileManager.saveProfile(profileName, controller.getSettings())
        self.showAddProfile = false
        profileName = ""
    }

    func canCreateProfile() -> Bool {
        guard let device = DevicesManager.shared.selectedDevice else {
            return false
        }
        return device.isConfigurable()
    }

    func deleteProfile() {
        guard let profile = selectedProfile else {
            return
        }

        profileManager.deleteProfile(profile)
        selectedProfile = nil
    }

    func updateProfile() {
        guard let profile = selectedProfile,
            let device = DevicesManager.shared.selectedDevice,
            let controller = device.controller else {
            return
        }

        profileManager.updateProfile(profile, controller.getSettings())
    }
}

struct ProfileSelector_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelector()
    }
}
