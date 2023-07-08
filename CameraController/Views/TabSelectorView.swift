//
//  TabSelectorView.swift
//  CameraController
//
//  Created by Itay Brenner on 16/6/23.
//  Copyright © 2023 Itaysoft. All rights reserved.
//

import SwiftUI

struct TabSelectorView: View {
    private struct TabOptions {
        var text: String
        var image: String
        var index: Int
    }
    private struct ViewConstants {
        static let height = 80.0
        static let itemWidth = 75.0
        static let itemSpacing = 10.0
    }

    @Binding var selectedIndex: Int?
    @State var displayedIndex: Int?

    private let optionsImages: [TabOptions] = [
        TabOptions(text: "Basic", image: "video", index: 0),
        TabOptions(text: "Advanced", image: "camera.filters", index: 1),
        TabOptions(text: "Profiles", image: "bookmark", index: 2),
        TabOptions(text: "Settings", image: "gearshape", index: 3)
    ]

    var body: some View {
        ZStack {
            if let selectedIndex = displayedIndex {
                GeometryReader { _ in
                    selectorIndicator(selectedIndex)
                        .frame(height: ViewConstants.height)
                }
            }

            HStack(spacing: ViewConstants.itemSpacing) {
                ForEach(optionsImages, id: \.text) { option in
                    Button {
                        self.changeSelectedIndex(option.index)
                    } label: {
                        VStack {
                            Image(systemName: option.image)
                                .font(.system(size: 30))
                            Spacer()
                                .frame(height: ViewConstants.itemSpacing)
                            Text(option.text)
                        }
                        .frame(width: ViewConstants.itemWidth, height: ViewConstants.height)
                        .cornerRadius(Constants.Style.cornerRadius)
                        .foregroundColor(colorForOption(option.index))
                    }
                    .buttonStyle(.borderless)
                }
            }
        }
        .frame(
            width: selectorWidth(optionsImages.count)
        )
        .onChange(of: selectedIndex) { newValue in
            // Fix for indicator moving up/down because of window resize
            DispatchQueue.main.async {
                withAnimation {
                    displayedIndex = newValue
                }
            }
        }
    }
    private func selectorWidth(_ optionsCount: Int) -> CGFloat {
        let itemWidthAndSpacing = ViewConstants.itemWidth + ViewConstants.itemSpacing
        return CGFloat(optionsCount) * itemWidthAndSpacing + ViewConstants.itemSpacing
    }

    private func colorForOption(_ index: Int) -> Color {
        if index == displayedIndex {
            return Constants.Colors.accentColor
        }
        return Constants.Colors.regularColor
    }

    private func selectorIndicator(_ index: Int) -> some View {
        return RoundedRectangle(cornerRadius: Constants.Style.cornerRadius)
            .stroke(Constants.Colors.border, lineWidth: 1)
            .background(
                RoundedRectangle(cornerRadius: Constants.Style.cornerRadius)
                    .fill(Constants.Colors.sectionBackground)
            )
            .frame(width: ViewConstants.itemWidth)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
            .offset(
                x: ViewConstants.itemSpacing + CGFloat(index) * (ViewConstants.itemWidth + ViewConstants.itemSpacing)
            )
            .animation(.spring().speed(0.75), value: displayedIndex)
    }

    private func changeSelectedIndex(_ newIndex: Int) {
        if selectedIndex == newIndex {
            selectedIndex = nil
        } else {
            selectedIndex = newIndex
        }
    }
}

struct TabSelectorView_Previews: PreviewProvider {

    static var previews: some View {
        StatefulPreviewWrapper(Int?(0)) { value in
            VStack(spacing: 20.0) {
                TabSelectorView(
                    selectedIndex: value
                )
            }
            .background(Constants.Colors.background)
        }
    }
}
