//
//  OrientationView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct OrientationView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Zoom/Pan/Tilt")) {
            VStack(spacing: 3.0) {
                
                CustomSlider(title: "Zoom:",
                             deviceProperty: controller.zoomAbsolute,
                             value: $controller.zoomAbsolute.sliderValue)
                
                CustomSlider(title: "Tilt:",
                             maximum: controller.panTiltAbsolute.maximum1,
                             minimum: controller.panTiltAbsolute.minimum1,
                             defaultValue: controller.panTiltAbsolute.defaultValue1,
                             isCapable: controller.zoomAbsolute.isCapable,
                             value: $controller.panTiltAbsolute.sliderValue1)
                
                CustomSlider(title: "Pan:",
                             maximum: controller.panTiltAbsolute.maximum2,
                             minimum: controller.panTiltAbsolute.minimum2,
                             defaultValue: controller.panTiltAbsolute.defaultValue2,
                             isCapable: controller.zoomAbsolute.isCapable,
                             value: $controller.panTiltAbsolute.sliderValue2)
            }
        }
    }
}
