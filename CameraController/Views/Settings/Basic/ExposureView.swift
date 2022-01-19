//
//  ExposureView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct ExposureView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Exposure")) {
            VStack(spacing: 3.0) {
                HStack {
                    Text("Mode:")
                    Spacer()
                    Picker(selection: $controller.exposureMode.selected, label: EmptyView()) {
                        Text("Manual").tag(UVCBitmapControl.BitmapValue.manual)
                        Text("Auto").tag(UVCBitmapControl.BitmapValue.aperturePriority)
                    }
                .   disabled(!controller.exposureMode.isCapable)
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300, height: 20.0)
                }

                CustomSlider(title: "Exposure Time:",
                             deviceProperty: controller.exposureTime,
                             value: $controller.exposureTime.sliderValue)
                    .disabled(!optionsEnabled() || !controller.exposureTime.isCapable)
                CustomSlider(title: "Gain:",
                             deviceProperty: controller.gain,
                             value: $controller.gain.sliderValue)
                    .disabled(!optionsEnabled() || !controller.gain.isCapable)
            }
        }
    }

    func optionsEnabled() -> Bool {
        return controller.exposureMode.selected == .manual
    }
}
