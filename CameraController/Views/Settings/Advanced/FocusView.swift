//
//  FocusView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct FocusView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Focus")) {
            HStack {
                Toggle(isOn: $controller.focusAuto.isEnabled) {
                    Text("Auto")
                }
                .disabled(!controller.focusAuto.isCapable)

                Spacer()
                Slider(value: $controller.focusAbsolute.sliderValue,
                       in: controller.focusAbsolute.minimum...controller.focusAbsolute.maximum)
                    .frame(width: 300, height: 15)
                    .disabled(!controller.focusAbsolute.isCapable)
            }
        }
    }
}

//struct FocusView_Previews: PreviewProvider {
//    static var previews: some View {
//        FocusView()
//    }
//}
