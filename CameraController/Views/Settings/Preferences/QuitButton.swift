//
//  QuitButton.swift
//  CameraController
//
//  Created by Itay Brenner on 9/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct QuitButton: View {
    var body: some View {
        HStack {
            Spacer()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.plain)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Constants.Colors.sliderBackground)
            .clipShape(Capsule())

            Spacer()
        }
    }
}

#if DEBUG
struct QuitButton_Previews: PreviewProvider {
    static var previews: some View {
        QuitButton()
    }
}
#endif
