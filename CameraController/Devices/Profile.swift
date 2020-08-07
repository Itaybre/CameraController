//
//  Profile.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

struct Profile: Codable, Hashable {
    let name: String
    let settings: DeviceSettings

    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
