//
//  NewSliderView.swift
//  CameraController
//
//  Created by Itay Brenner on 17/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct Slider: View {
    @Binding var value: Float
    @Environment(\.isEnabled) var isEnabled: Bool

    @State var lastCoordinateValue: Float = 0.0
    let sliderRange: ClosedRange<Float>
    let step: Float
    let minTrackColor: Color = Constants.Colors.accentColor
    let maxTrackColor: Color = Constants.Colors.sliderBackground
    let disabledColor: Color = Constants.Colors.disabledSlider
    let activeThumbColor: Color = Constants.Colors.activeThumbSlider
    let disabledThumbColor: Color = Constants.Colors.disabledThumbSlider

    init(value: Binding<Float>,
         step: Float = 1,
         sliderRange: ClosedRange<Float> = 0...100) {
        _value = value
        self.step = step
        self.sliderRange = sliderRange
        self.lastCoordinateValue = lastCoordinateValue
    }

    var body: some View {
        GeometryReader { geoReader in
            let thumbHeight = geoReader.size.height
            let thumbWidth = geoReader.size.height
            let radius = geoReader.size.height * 0.5
            let maxValue = geoReader.size.width - thumbWidth

            let scaleFactor = Float(maxValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor

            let activeColor = isEnabled ? minTrackColor : disabledColor
            let thumbColor = isEnabled ? activeThumbColor : disabledThumbColor

            ZStack {
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(width: geoReader.size.width, height: geoReader.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    Rectangle()
                        .foregroundColor(activeColor)
                        .frame(width: CGFloat(sliderVal) + thumbWidth/2, height: geoReader.size.height * 0.95)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: radius))
                HStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(thumbColor)
                        .frame(width: thumbWidth, height: thumbHeight)
                        .shadow(radius: 5)
                        .offset(x: CGFloat(sliderVal))
                    Spacer()
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        let percentage = min(
                            max(
                                Float(value.location.x-thumbWidth/2) / Float(geoReader.size.width-thumbWidth),
                                0),
                            1
                        )
                        let tmpValue = percentageToValueInRange(percentage, sliderRange)
                        self.value = tmpValue - tmpValue.truncatingRemainder(dividingBy: step)
                    }
            )
            .allowsHitTesting(self.isEnabled)
        }
        .frame(height: 22)
    }

    private func percentageToValueInRange(_ percentage: Float, _ range: ClosedRange<Float>) -> Float {
        return range.lowerBound + (range.upperBound - range.lowerBound) * percentage
    }
}

struct NewSliderView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(Float(40.0)) { value in
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Regular")
                    Slider(value: value)
                        .frame(width: 320, height: 30)
                }
                Divider()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Disabled")
                    Slider(value: value)
                        .frame(width: 320, height: 30)
                }
                Divider()
                VStack(alignment: .leading, spacing: 5) {
                    Text("With steps")
                    Slider(value: value, step: 10)
                        .frame(width: 320, height: 30)
                }
            }
            .frame(width: 320, height: 180)
            .padding()
        }
    }
}
