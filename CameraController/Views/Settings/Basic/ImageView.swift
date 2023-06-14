//
//  ImageView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/24/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Image")) {
            VStack(spacing: 3.0) {
                SliderOption(property: $controller.brightness, title: "Brightness:")
                SliderOption(property: $controller.contrast, title: "Contrast:")
                SliderOption(property: $controller.saturation, title: "Saturation:")
                SliderOption(property: $controller.sharpness, title: "Sharpness")
            }
        }

        if controller.hue.maximum > 0 {
            GroupBox(label: Text("Hue")) {
                VStack(spacing: 3.0) {
                    SliderOptionWithAuto(valueProperty: $controller.hue, autoProperty: $controller.hueAuto)
                }
            }
        }
    }
}
