//
//  BacklightView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct BacklightView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Backlight Compensation")) {
            HStack {
                Spacer()
                Picker(selection: $controller.backlightCompensation.sliderValue, label: EmptyView()) {
                    Text("Off").tag(0 as Float)
                    Text("On").tag(1 as Float)
                }
                .disabled(!controller.backlightCompensation.isCapable)
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300, height: 20.0)
            }
        }
    }
}

//struct BacklightView_Previews: PreviewProvider {
//    static var previews: some View {
//        BacklightView()
//    }
//}
