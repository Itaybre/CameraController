//
//  SectionView.swift
//  CameraController
//
//  Created by Itay Brenner on 18/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.Style.cornerRadius)
                .stroke(Constants.Colors.border, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: Constants.Style.cornerRadius)
                        .fill(Constants.Colors.sectionBackground)
                )

            VStack(alignment: .leading, spacing: Constants.Style.padding) {
                content()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
    }
}

#if DEBUG
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView {
            HStack(spacing: 20.0) {
                Toggle(isOn: .constant(false))
                    .toggleStyle(SwitchToggleStyle(tint: Constants.Colors.accentColor))
                StatefulPreviewWrapper(Float(40.0)) { value in
                    Slider(value: value, step: 10)
                        .frame(height: 22)
                }
            }
        }
        .frame(width: 320)
        .padding()
    }
}
#endif
