//
//  AutoBadge.swift
//  CameraController
//
//  Created by Itay Brenner on 4/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct AutoBadge: View {
    var body: some View {
        Text("Auto")
            .font(.caption.bold())
            .foregroundColor(Constants.Colors.accentColor)
            .padding(.horizontal, Constants.Style.padding)
            .background(
                RoundedRectangle(cornerRadius: Constants.Style.smallCornerRadius)
                    .strokeBorder(Constants.Colors.accentColor)
                    .padding(.vertical, -2)
            )
    }
}

#if DEBUG
struct AutoBadge_Previews: PreviewProvider {
    static var previews: some View {
        AutoBadge()
            .padding(.all)
    }
}
#endif
