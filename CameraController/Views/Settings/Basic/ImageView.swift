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
                HStack {
                    Text("Brightness:")
                    Spacer()
                    Slider(value: $controller.brightness.sliderValue,
                            in: controller.brightness.minimum...controller.brightness.maximum)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.brightness.isCapable)
                }
                HStack {
                    Text("Contrast:")
                    Spacer()
                    Slider(value: $controller.contrast.sliderValue,
                            in: controller.contrast.minimum...controller.contrast.maximum)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.brightness.isCapable)
                }
                HStack {
                    Text("Saturation:")
                    Spacer()
                    Slider(value: $controller.saturation.sliderValue,
                            in: controller.saturation.minimum...controller.saturation.maximum)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.brightness.isCapable)
                }
                HStack {
                    Text("Sharpness:")
                    Spacer()
                    Slider(value: $controller.sharpness.sliderValue,
                            in: controller.sharpness.minimum...controller.sharpness.maximum)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.brightness.isCapable)
                }
            }
        }
    }
}
