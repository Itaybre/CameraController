//
//  GenericControl.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI
import AppKit

struct GenericControl: View {
    @Binding var value: Float
    @Binding var auto: Bool
    @State var step: Float
    @State var range: ClosedRange<Float>

    let title: String
    let imageName: String
    let hasAuto: Bool

    init(value: Binding<Float>,
         step: Float,
         range: ClosedRange<Float>,
         title: String,
         imageName: String,
         auto: Binding<Bool>?) {
        self._value = value
        self.step = step
        self.range = range
        self.title = title
        self.imageName = imageName
        self.hasAuto = auto != nil
        self._auto = auto ?? .constant(false)
    }

    var body: some View {
        SectionView {
            SectionTitle(title: title,
                         image: image(imageName)) {
                if hasAuto,
                   $auto.wrappedValue {
                    AutoBadge()
                        .transition(.opacity)
                } else {
                    EmptyView()
                }
            }

            HStack {
                if hasAuto {
                    Toggle(isOn: $auto.animation())
                } else {
                    Toggle(isOn: .constant(false))
                        .hidden()
                }
                Slider(value: $value,
                          step: step,
                          sliderRange: range)
                    .disabled($auto.wrappedValue)
            }
        }
    }

    private func image(_ name: String) -> Image {
        if let image = NSImage.init(systemSymbolName: name, accessibilityDescription: nil) {
            return Image(nsImage: image)
        }
        return Image(name)
    }
}
