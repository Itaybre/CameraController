//
//  WhiteBalanceView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/24/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct WhiteBalanceView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("White Balance")) {
            HStack {
                Toggle(isOn: $controller.whiteBalanceAuto.isEnabled) {
                    Text("Auto")
                }

                Spacer()
                Slider(value: $controller.whiteBalance.sliderValue,
                       in: controller.whiteBalance.minimum...controller.whiteBalance.maximum)
                    .frame(width: 300, height: 15)
                    .disabled(controller.whiteBalanceAuto.isEnabled)
            }
        }
    }
}

//struct WhiteBalanceView_Previews: PreviewProvider {
//    static var previews: some View {
//        WhiteBalanceView()
//    }
//}
