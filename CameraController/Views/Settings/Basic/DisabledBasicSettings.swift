//
//  DisabledBasicSettings.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct DisabledBasicSettings: View {
    var body: some View {
        VStack(spacing: 3) {
            Spacer()

            Text("Unsupported Camera")
                .font(.system(size: 20).bold())

            Text("Please connect a UVC compliant camera.")
                .font(.caption.bold())

            Spacer()
        }
    }
}

struct DisabledBasicSettings_Previews: PreviewProvider {
    static var previews: some View {
        DisabledBasicSettings()
    }
}
