//
//  BasicSettings.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct BasicSettings: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        VStack {
            ExposureView(controller: controller)
            ImageView(controller: controller)
            WhiteBalanceView(controller: controller)
        }
    }
}

//struct BasicSettings_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicSettings()
//    }
//}
