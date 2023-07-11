//
//  BasicSettings.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct BasicSettings: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: Constants.Style.controlsSpacing) {
                if controller.exposureTime.isCapable {
                    ExposureView(controller: controller)
                }

                if controller.brightness.isCapable {
                    BrightnessView(controller: controller)
                }

                if controller.contrast.isCapable {
                    ContrastView(controller: controller)
                }

                if controller.saturation.isCapable {
                    SaturationView(controller: controller)
                }

                if controller.sharpness.isCapable {
                    SharpnessView(controller: controller)
                }

                if controller.hue.isCapable && controller.hue.maximum > 0 {
                    HueView(controller: controller)
                }

                if controller.whiteBalance.isCapable {
                    WhiteBalanceView(controller: controller)
                }

                Spacer()
                    .frame(height: 8)
            }
        }
        .frame(maxHeight: 300)
    }
}
