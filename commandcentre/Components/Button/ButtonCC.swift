//
//  ButtonCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

// MARK: - Button

struct ButtonCC<ImageView: View, TextView: View>: View {

    private let image: ImageView
    private let text: TextView
    private let action: () -> Void

    init(
        action: @escaping () -> Void,
        @ViewBuilder image: () -> ImageView,
        @ViewBuilder text: () -> TextView
    ) {
        self.action = action
        self.image = image()
        self.text = text()
    }

    var body: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(ButtonCCStyle())
    }

}

extension ButtonCC where ImageView == Image, TextView == Text {

    init(image: Image, text: String, action: @escaping () -> Void) {
        self.init(
            action: action,
            image: { image },
            text: { Text(String(text.uppercased())) }
        )
    }

}

private extension ButtonCC {

    @ViewBuilder var label: some View {
        HStack(spacing: 4) {
            image
                .frame(width: 56, height: 56)
                .aspectRatio(contentMode: .fit)

            text
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Spacer(minLength: 0)
        }
        .font(Fonts.largeTitle)
        .foregroundStyle(Color.Cc.cyan)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

// MARK: - Button style

private struct ButtonCCStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        let frameColor = configuration.isPressed ? Color.Cc.crimson : Color.Cc.crimsonDark

        return configuration.label
            .overlay {
                ChipCCFrameShape(isTopInsetEnabled: true)
                    .strokeBorder(frameColor, lineWidth: 2)
            }
            .overlay(alignment: .leading) {
                ChipCCLeadingBarShape()
                    .fill(frameColor)
                    .frame(width: 6)
                    .offset(x: -6)
            }
            .contentShape(ChipCCFrameShape(isTopInsetEnabled: true))
            .animation(.easeOut(duration: 0.06), value: configuration.isPressed)
    }

}

// MARK: - Previews

#Preview("Default") {
    ZStack {
        Color.black.ignoresSafeArea()

        ButtonCC(image: Image(systemName: "chart.xyaxis.line"), text: "Stats") {
            print("Pressed")
        }
        .padding(.horizontal, 16)
    }
}

#Preview("Compact") {
    ZStack {
        Color.black.ignoresSafeArea()

        ButtonCC(image: Image(systemName: "desktopcomputer.and.macbook"), text: "Systems") {
            print("Pressed")
        }
        .frame(width: 240)
        .padding(.horizontal, 16)
    }
}
