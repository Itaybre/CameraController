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

                SliderOption(property: $controller.exposureTime, title: "Exposure Time:")
                    .disabled(!optionsEnabled())
                SliderOption(property: $controller.gain, title: "Gain:")
                    .disabled(!optionsEnabled())
            }
        }
    }

    func optionsEnabled() -> Bool {
        return controller.exposureMode.selected == .manual
    }
}
