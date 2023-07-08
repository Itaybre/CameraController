//
//  StatefulPreviewWrapper.swift
//  CameraController
//
//  Created by Itay Brenner on 17/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

#if DEBUG
// Code extracted from Jim Dovey's response at
//   https://developer.apple.com/forums/thread/118589?answerId=398579022#398579022
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
#endif
