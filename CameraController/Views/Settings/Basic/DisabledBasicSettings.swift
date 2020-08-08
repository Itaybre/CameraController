//
//  DisabledBasicSettings.swift
//  CameraController
//
//  Created by Itay Brenner on 8/7/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct DisabledBasicSettings: View {
    var body: some View {
        VStack {
            GroupBox(label: Text("Exposure")) {
                VStack(spacing: 3.0) {
                    HStack {
                        Text("Mode:")
                        Spacer()
                        Picker(selection: .constant(0.0), label: EmptyView()) {
                            Text("Manual").tag(1)
                            Text("Auto").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 300, height: 20.0)
                    }
                    slider("Exposure Time:")
                    slider("Gain:")
                }
            }

            GroupBox(label: Text("Image")) {
                VStack(spacing: 3.0) {
                    slider("Brightness:")
                    slider("Contrast:")
                    slider("Saturation:")
                    slider("Sharpness:")
                }
            }

            GroupBox(label: Text("White Balance")) {
                HStack {
                    Toggle(isOn: .constant(false)) {
                        Text("Auto")
                    }

                    Spacer()
                    Slider(value: .constant(0.0), in: 0...1).frame(width: 300, height: 15.0)
                }
            }
        }.disabled(true)
    }

    func slider(_ name: String) -> some View {
        HStack {
            Text(name)
            Spacer()
            Slider(value: .constant(0.0), in: 0...1).frame(width: 300, height: 15.0)
        }
    }
}

struct DisabledBasicSettings_Previews: PreviewProvider {
    static var previews: some View {
        DisabledBasicSettings()
    }
}
