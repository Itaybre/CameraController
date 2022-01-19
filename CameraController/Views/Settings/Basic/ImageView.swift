//
//  ImageView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/24/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var sliderValue: Float
    @State var showField: Bool = false
    @State var random: Float = 0

    let minimum: Float
    let maximum: Float
    let isCapable: Bool
    let title: String
    let formatter: NumberFormatter

    init(title: String, deviceProperty: NumberCaptureDeviceProperty, value: Binding<Float>) {
        self.title = title
        minimum = deviceProperty.minimum
        maximum = deviceProperty.maximum
        isCapable = deviceProperty.isCapable
        _sliderValue = value

        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0
        formatter.minimum = NSNumber(value: minimum)
        formatter.maximum = NSNumber(value: maximum)
    }

    init(title: String, value: Binding<Float>) {
        self.title = title
        minimum = 0
        maximum = 255
        isCapable = false
        _sliderValue = value

        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0
        formatter.minimum = NSNumber(value: minimum)
        formatter.maximum = NSNumber(value: maximum)
    }

    var body: some View {
        HStack {
            Text(title)
                .onTapGesture(count: 2) {
                    showField = !showField
                }

            Spacer()

            if showField {
                HStack {
                    Button("-") {
                        random -= 1
                    }.disabled(random <= minimum)
                    Spacer()
                    TextField("", value: $random, formatter: formatter)
                        .multilineTextAlignment(.center)
                        .frame(width: 50, height: 18)
                    Spacer()
                    Button("+") {
                        random += 1
                    }.disabled(random >= maximum)
                }.frame(width: 300)
            } else {
                Slider(value: $random,
                    in: minimum...maximum)
                    .frame(width: 300, height: 18)
                    .disabled(!isCapable)
            }
        }
    }
}

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
