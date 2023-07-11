//
//  Toggle.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct Toggle: View {
    @Binding var isOn: Bool

    var body: some View {
        SwiftUI.Toggle(isOn: $isOn.animation()) {}
            .toggleStyle(SwitchToggleStyle(tint: Constants.Colors.accentColor))
            .labelsHidden()
    }
}

struct Toggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Toggle(isOn: .constant(false))
            Toggle(isOn: .constant(true))
        }
    }
}
