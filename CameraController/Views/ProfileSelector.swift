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
    @ObservedObject var profileManager = ProfileManager.shared
    @State var selectedProfile: Profile?

    private let buttonWidth: CGFloat = 110

    var body: some View {
        GroupBox(label: Text("Profile")) {
            VStack {
                HStack {
                    Button(action: {}) {
                        Text("Save Profile")
                            .frame(width: self.buttonWidth)
                    }

                    Button(action: {}) {
                        Text("Update Profile")
                        .frame(width: self.buttonWidth)
                    }

                    Button(action: {}) {
                        Text("Delete Profile")
                        .frame(width: self.buttonWidth)
                    }
                }

                Picker(selection: $selectedProfile, label: EmptyView()) {
                    ForEach(profileManager.profiles, id: \.self) { profile in
                        Text(profile.name).tag(profile as Profile?)
                    }
                }
            }
        }
    }
}

struct ProfileSelector_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelector()
    }
}
