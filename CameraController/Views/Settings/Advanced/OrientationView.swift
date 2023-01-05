//
//  OrientationView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/25/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct OrientationView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Zoom/Pan/Tilt/Roll")) {
            VStack(spacing: 3.0) {
                SliderOption(property: $controller.zoomAbsolute, title: "Zoom:")
                DualSliderOption(property: $controller.panTiltAbsolute, title1: "Tilt:", title2: "Pan:")
                SliderOption(property: $controller.rollAbsolute, title: "Roll:")
            }
        }
    }
}

//struct OrientationView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrientationView()
//    }
//}
