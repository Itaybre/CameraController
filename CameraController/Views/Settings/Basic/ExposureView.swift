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

                HStack {
                    Text("Exposure Time:")
                    Spacer()
                    Slider(value: $controller.exposureTime.sliderValue, in:
                        controller.exposureTime.minimum...controller.exposureTime.maximum)
                        .disabled(!optionsEnabled() || !controller.exposureTime.isCapable)
                        .frame(width: 300, height: 15.0)
                }

                HStack {
                    Text("Gain:")
                    Spacer()
                    Slider(value: $controller.gain.sliderValue, in: controller.gain.minimum...controller.gain.maximum)
                        .disabled(!optionsEnabled() || !controller.gain.isCapable)
                        .frame(width: 300, height: 15.0)
                }
            }
        }
    }

    func optionsEnabled() -> Bool {
        return controller.exposureMode.selected == .manual
    }
}

//struct ExposureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExposureView()
//    }
//}
