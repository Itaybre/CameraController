//
//  CameraSection.swift
//  CameraController
//
//  Created by Itay Brenner on 9/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct CameraSection: View {
    @ObservedObject var manager = DevicesManager.shared

    var body: some View {
        SectionView {
            SectionTitle(title: "Camera",
                         image: Image(systemName: "web.camera"))

            HStack(spacing: 20.0) {
                Text("Camera")
                Spacer()
                Picker(selection: $manager.selectedDevice, label: Text("")) {
                    Text("None").tag(nil as CaptureDevice?)
                    ForEach(manager.devices, id: \.self) { device in
                        Text(device.name).tag(device as CaptureDevice?)
                    }
                }.frame(width: 200)
            }
        }
    }
}

struct CameraSection_Previews: PreviewProvider {
    static var previews: some View {
        CameraSection()
    }
}
