//
//  UnsupportedView.swift
//  CameraController
//
//  Created by Itay Brenner on 26/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct UnsupportedView: View {
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

#if DEBUG
struct UnsupportedView_Previews: PreviewProvider {
    static var previews: some View {
        UnsupportedView()
    }
}
#endif
