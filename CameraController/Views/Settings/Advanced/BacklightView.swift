//
//  BacklightView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct BacklightView: View {
    @ObservedObject var backlightCompensation: NumberCaptureDeviceProperty

    init(controller: DeviceController) {
        self.backlightCompensation = controller.backlightCompensation
    }

    var body: some View {
        SectionView {
            SectionTitle(title: "Backlight Compensation",
                         image: Image(systemName: "light.beacon.max")) {
                Toggle(isOn: backightEnabled)
            }
        }
    }

    var backightEnabled: Binding<Bool> {
        Binding(get: {
            backlightCompensation.sliderValue > 0
        }, set: {
            backlightCompensation.sliderValue = $0 ? backlightCompensation.maximum : 0
        })
    }
}
