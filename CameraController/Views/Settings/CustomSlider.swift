//
//  CustomSlider.swift
//  CameraController
//
//  Created by Itay Brenner on 19/1/22.
//  Copyright © 2022 Itaysoft. All rights reserved.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var sliderValue: Float
    @State var showField: Bool = false

    let minimum: Float
    let maximum: Float
    let defaultValue: Float
    let isCapable: Bool
    let title: String
    let formatter: NumberFormatter

    init(title: String, deviceProperty: NumberCaptureDeviceProperty, value: Binding<Float>) {
        self.title = title
        minimum = deviceProperty.minimum
        maximum = deviceProperty.maximum
        defaultValue = deviceProperty.defaultValue
        isCapable = deviceProperty.isCapable
        _sliderValue = value

        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0
        formatter.minimum = NSNumber(value: minimum)
        formatter.maximum = NSNumber(value: maximum)
    }

    init(title: String, maximum: Float, minimum: Float, defaultValue: Float, isCapable: Bool, value: Binding<Float>) {
        self.title = title
        self.minimum = minimum
        self.maximum = maximum
        self.defaultValue = defaultValue
        self.isCapable = isCapable
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
        defaultValue = 128
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
                        sliderValue -= 1
                    }.disabled(sliderValue <= minimum)
                    Spacer()
                    TextField("", value: $sliderValue, formatter: formatter)
                        .multilineTextAlignment(.center)
                        .frame(width: 32, height: 18)
                    Button("Reset") {
                        sliderValue = defaultValue
                    }
                    Spacer()
                    Button("+") {
                        sliderValue += 1
                    }.disabled(sliderValue >= maximum)
                }.frame(width: 300)
            } else {
                Slider(value: $sliderValue,
                    in: minimum...maximum)
                    .frame(width: 300, height: 18)
                    .disabled(!isCapable)
            }
        }
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(title: "Test", value: .constant(128))
    }
}
