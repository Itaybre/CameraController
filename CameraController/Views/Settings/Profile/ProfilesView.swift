//
//  ProfilesView.swift
//  CameraController
//
//  Created by Itay Brenner on 26/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct ProfilesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ProfileSelector()
        }
    }
}

struct ProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesView()
    }
}
