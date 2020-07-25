//
//  AdvancedView.swift
//  CameraController
//
//  Created by Itay Brenner on 7/24/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct AdvancedView: View {
    @ObservedObject var controller: DeviceController

    var body: some View {
        VStack {
            PowerLineView(controller: controller)
            BacklightView(controller: controller)
            OrientationView(controller: controller)
            FocusView(controller: controller)
        }
    }
}

//struct AdvancedView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdvancedView()
//    }
//}
