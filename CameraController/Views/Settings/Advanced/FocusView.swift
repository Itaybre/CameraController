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
            SliderOptionWithAuto(valueProperty: $controller.focusAbsolute, autoProperty: $controller.focusAuto)
        }
    }
}

//struct FocusView_Previews: PreviewProvider {
//    static var previews: some View {
//        FocusView()
//    }
//}
