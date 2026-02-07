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
                .padding(.leading, 8)

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
            .background {
                HStack(spacing: 1) {
                    Rectangle()
                        .fill(frameColor)
                        .scaleEffect(1.03) // workaround
                        .frame(width: 8)

                    ButtonCCFrameShape()
                        .stroke(frameColor, lineWidth: 2)
                }
            }
            .contentShape(ButtonCCFrameShape())
            .animation(.easeOut(duration: 0.06), value: configuration.isPressed)
    }

}

// MARK: - Shape

private struct ButtonCCFrameShape: Shape {

    func path(in rect: CGRect) -> Path {
        let topCut = min(rect.height * 0.22, 6)
        let topInset = rect.height + topCut

        let trailingCut = min(rect.height * 0.35, 16)

        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - trailingCut, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - trailingCut))
        path.addLine(to: CGPoint(x: rect.maxX, y: topCut))
        path.addLine(to: CGPoint(x: topInset, y: topCut))
        path.addLine(to: CGPoint(x: topInset - topCut, y: 0))
        path.closeSubpath()

        return path
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
