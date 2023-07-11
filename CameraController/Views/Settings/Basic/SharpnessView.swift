//
//  SharpnessView.swift
//  CameraController
//
//  Created by Itay Brenner on 9/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct SharpnessView: View {
    @ObservedObject var sharpness: NumberCaptureDeviceProperty

    init(controller: DeviceController) {
        self.sharpness = controller.sharpness
    }

    var body: some View {
        GenericControl(value: $sharpness.sliderValue,
                       step: sharpness.resolution,
                       range: sharpness.minimum...sharpness.maximum,
                       title: "Sharpness",
                       imageName: "triangle.fill",
                       auto: nil)
    }
}
