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
                CustomSlider(title: "Brightness:",
                             deviceProperty: controller.brightness,
                             value: $controller.brightness.sliderValue)
                CustomSlider(title: "Contrast:",
                             deviceProperty: controller.contrast,
                             value: $controller.contrast.sliderValue)
                CustomSlider(title: "Saturation:",
                             deviceProperty: controller.saturation,
                             value: $controller.saturation.sliderValue)
                CustomSlider(title: "Sharpness:",
                             deviceProperty: controller.sharpness,
                             value: $controller.sharpness.sliderValue)
            }
        }
    }
}
