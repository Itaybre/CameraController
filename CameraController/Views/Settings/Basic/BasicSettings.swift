//
//  BasicSettings.swift
//  CameraController
//
//  Created by Itay Brenner on 7/21/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import SwiftUI

struct BasicSettings: View {
    var body: some View {
        VStack {
            ExposureView()
        }
    }
}

struct BasicSettings_Previews: PreviewProvider {
    static var previews: some View {
        BasicSettings()
    }
}
