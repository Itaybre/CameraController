//
//  ProfileManager.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation
import Combine

class ProfileManager: ObservableObject {
    static let shared = ProfileManager()

    @Published private(set) var profiles: [Profile] = []

    private init() {}

    func saveProfile(_ name: String, _ settings: DeviceSettings) {
        let newProfile = Profile(name: name, settings: settings)
        profiles.append(newProfile)
        saveProfiles()
    }

    func deleteProfile(_ profile: Profile) {
        guard let index = profiles.firstIndex(of: profile) else {
            return
        }

        profiles.remove(at: index)
        saveProfiles()
    }

    private func saveProfiles() {
        UserDefaults.standard.set(profiles, forKey: "profiles")
    }
}
