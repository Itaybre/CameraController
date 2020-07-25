//
//  PowerLineView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/24/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct PowerLineView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        GroupBox(label: Text("Powerline Frequency")) {
            HStack {
                Spacer()
                Picker(selection: $controller.powerLineFrequency.sliderValue, label: EmptyView()) {
                    Text("Disabled").frame(width: 100).tag(0 as Float)
                    Text("50 Hz").frame(width: 100).tag(1 as Float)
                    Text("60 Hz").frame(width: 100).tag(2 as Float)
                    Text("Auto").frame(width: 100).tag(3 as Float)
                }
                .disabled(!controller.powerLineFrequency.isCapable)
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
        }
    }
}

//struct PowerLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        PowerLineView()
//    }
//}
