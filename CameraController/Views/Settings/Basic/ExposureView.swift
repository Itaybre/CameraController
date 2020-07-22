//
//  ExposureView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct ExposureView: View {
    @State var mode: UVCBitmapControl.BitmapValue = .manual
    @State var time: Float = 1
    @State var gain: Float = 1

    var body: some View {
        GroupBox(label: Text("Exposure")) {
            VStack(spacing: 3.0) {
                HStack {
                    Text("Mode:")
                    Spacer()
                    Picker(selection: $mode, label: EmptyView()) {
                        Text("Manual").tag(UVCBitmapControl.BitmapValue.manual)
                        Text("Auto").tag(UVCBitmapControl.BitmapValue.aperturePriority)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300, height: 20.0)
                }

                HStack {
                    Text("Exposure Time:")
                    Spacer()
                    Slider(value: $time, in: 1...100)
                        .disabled(!optionsEnabled())
                        .frame(width: 300, height: 15.0)
                }

                HStack {
                    Text("Gain:")
                    Spacer()
                    Slider(value: $gain, in: 1...100)
                        .disabled(!optionsEnabled())
                        .frame(width: 300, height: 15.0)
                }
            }
        }
    }

    func optionsEnabled() -> Bool {
        return mode == .manual
    }
}

struct ExposureView_Previews: PreviewProvider {
    static var previews: some View {
        ExposureView()
    }
}
