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
            SliderOptionWithAuto(valueProperty: $controller.whiteBalance, autoProperty: $controller.whiteBalanceAuto)
        }
    }
}
