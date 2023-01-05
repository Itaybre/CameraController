//
//  File.swift
//  CameraController
//
//  Created by Itay Brenner on 5/1/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct SliderOption: View {
    @Binding var property: NumberCaptureDeviceProperty
    var title: String

    var body: some View {
        if property.maximum > 0 {
            HStack {
                Text(title)
                Spacer()
                Slider(value: $property.sliderValue,
                       in: property.minimum...property.maximum)
                .frame(width: 300, height: 20.0)
                .disabled(!property.isCapable)
            }
        } else {
            EmptyView()
        }
    }
}
