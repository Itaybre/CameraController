//
//  SliderOptionWithAuto.swift
//  CameraController
//
//  Created by Itay Brenner on 5/1/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct SliderOptionWithAuto: View {
    @Binding var valueProperty: NumberCaptureDeviceProperty
    @Binding var autoProperty: BoolCaptureDeviceProperty

    var body: some View {
        if valueProperty.maximum > 0 {
            HStack {
                Toggle(isOn: $autoProperty.isEnabled) {
                    Text("Auto")
                }
                .disabled(!autoProperty.isCapable)

                Spacer()
                Slider(value: $valueProperty.sliderValue,
                       in: valueProperty.minimum...valueProperty.maximum)
                    .frame(width: 300, height: 20)
                    .disabled(!valueProperty.isCapable || autoProperty.isEnabled)
            }
        } else {
            EmptyView()
        }
    }
}
