//
//  DualSliderOption.swift
//  CameraController
//
//  Created by Itay Brenner on 5/1/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct DualSliderOption: View {
    @Binding var property: MultipleCaptureDeviceProperty
    var title1: String
    var title2: String

    var body: some View {
        HStack {
            Text(title1)
            Spacer()
            Slider(value: $property.sliderValue1,
                   in: property.minimum1...property.maximum1)
                .frame(width: 300, height: 20.0)
                .disabled(!property.isCapable)
        }
        HStack {
            Text(title2)
            Spacer()
            Slider(value: $property.sliderValue2,
                   in: property.minimum2...property.maximum2)
                .frame(width: 300, height: 20.0)
                .disabled(!property.isCapable)
        }
    }
}
