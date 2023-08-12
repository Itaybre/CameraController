//
//  Constants.swift
//  CameraController
//
//  Created by Itay Brenner on 17/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import Foundation
import SwiftUI

struct Constants {
    struct Colors {
        static let accentColor = Color(red: 246/255, green: 193/255, blue: 75/255)
        static let regularColor = Color(white: 1, opacity: 1)

        static let background = Color(red: 42/255, green: 41/255, blue: 49/255)

        static let sectionBackground = Color(white: 1, opacity: 0.1)
        static let border = Color(white: 1, opacity: 0.4)

        static let sliderBackground = Color(red: 13/255, green: 15/255, blue: 28/255)
        static let disabledSlider = Color(red: 43/255, green: 52/255, blue: 54/255)

        static let activeThumbSlider = Color.white
        static let disabledThumbSlider = Color(red: 69/255, green: 70/255, blue: 77/255)
    }

    struct Style {
        static let cornerRadius = 10.0
        static let smallCornerRadius = 4.0
        static let padding = 5.0
        static let controlsSpacing = 8.0
        static let topSpacing = 2.0
    }
}
