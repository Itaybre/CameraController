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

    @State private var showField: Bool = false
    private let formatter: NumberFormatter

    init(property: Binding<NumberCaptureDeviceProperty>, title: String) {
        _property = property
        self.title = title

        formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0
        formatter.minimum = NSNumber(value: _property.wrappedValue.minimum)
        formatter.maximum = NSNumber(value: _property.wrappedValue.maximum)
    }

    var body: some View {
        if property.maximum > 0 {
            HStack {
                Text(title)
                    .onTapGesture(count: 1) {
                        showField = false
                    }
                    .onLongPressGesture {
                        showField = !showField
                    }

                Spacer()

                if showField {
                    HStack {
                        Button("-") {
                            property.sliderValue -= 1
                        }.disabled(property.sliderValue <= property.minimum)

                        Spacer()

                        TextField("\(Int(property.minimum))-\(Int(property.maximum))",
                                  value: $property.sliderValue,
                                  formatter: formatter)
                            .multilineTextAlignment(.center)
                            .frame(width: 60, height: 20)
                        Button("Reset") {
                            property.sliderValue = property.defaultValue
                        }

                        Spacer()

                        Button("+") {
                            property.sliderValue += 1
                        }
                        .disabled(property.sliderValue >= property.maximum)
                    }.frame(width: 300)
                } else {
                    Slider(value: $property.sliderValue,
                           in: property.minimum...property.maximum)
                    .frame(width: 300, height: 20.0)
                    .disabled(!property.isCapable)
                }
            }
        } else {
            EmptyView()
        }
    }
}
