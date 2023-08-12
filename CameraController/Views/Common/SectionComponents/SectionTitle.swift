//
//  SectionTitle.swift
//  CameraController
//
//  Created by Itay Brenner on 4/7/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct SectionTitle<Content: View>: View {
    let title: String
    let image: Image
    let accessoryContent: () -> Content

    init(title: String, image: Image, @ViewBuilder accessoryContent: @escaping () -> Content = { EmptyView() }) {
        self.title = title
        self.image = image
        self.accessoryContent = accessoryContent
    }

    var body: some View {
        HStack(spacing: 10) {
            image
            Text(title)
                .fontWeight(.heavy)

            Spacer()
            accessoryContent()
        }
    }
}

struct SectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SectionTitle(title: "Camera",
                         image: Image(systemName: "web.camera"))

            SectionTitle(title: "Camera",
                         image: Image(systemName: "web.camera")) {
                Text("1.0s")
            }
        }
    }
}
