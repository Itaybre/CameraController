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
        GroupBox(label: Text("Zoom/Pan/Tilt")) {
            VStack(spacing: 3.0) {
                HStack {
                    Text("Zoom:")
                    Spacer()
                    Slider(value: $controller.zoomAbsolute.sliderValue,
                            in: controller.zoomAbsolute.minimum...controller.zoomAbsolute.maximum)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.zoomAbsolute.isCapable)
                }
                HStack {
                    Text("Tilt:")
                    Spacer()
                    Slider(value: $controller.panTiltAbsolute.sliderValue1,
                           in: controller.panTiltAbsolute.minimum1...controller.panTiltAbsolute.maximum1)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.panTiltAbsolute.isCapable)
                }
                HStack {
                    Text("Pan:")
                    Spacer()
                    Slider(value: $controller.panTiltAbsolute.sliderValue2,
                           in: controller.panTiltAbsolute.minimum2...controller.panTiltAbsolute.maximum2)
                        .frame(width: 300, height: 15.0)
                        .disabled(!controller.panTiltAbsolute.isCapable)
                }
            }
        }
    }
}

//struct OrientationView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrientationView()
//    }
//}
