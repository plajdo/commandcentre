//
//  LabelCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

struct LabelCC: View {

    private let text: String
    private let font: Font
    private let color: Color

    init(_ text: String, font: Font, color: Color) {
        self.text = text
        self.font = font
        self.color = color
    }

    init(_ style: Style, _ text: String) {
        self.init(text, font: style.font, color: style.color)
    }

    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(color)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }

}

// MARK: - Style

extension LabelCC {

    enum Style {

        case titlePrimary
        case bodyPrimary
        case captionPrimary
        case bodySecondary

        var font: Font {
            switch self {
            case .titlePrimary:
                return Fonts.title
            case .bodyPrimary:
                return Fonts.body
            case .captionPrimary:
                return Fonts.caption
            case .bodySecondary:
                return Fonts.body
            }
        }

        var color: Color {
            switch self {
            case .titlePrimary:
                return Color.Cc.crimson
            case .bodyPrimary:
                return Color.Cc.crimson
            case .captionPrimary:
                return Color.Cc.crimson
            case .bodySecondary:
                return Color.Cc.cyanMid
            }
        }

    }

}

// MARK: - Previews

#Preview("Styles") {
    ZStack {
        Color.black.ignoresSafeArea()

        VStack(alignment: .leading, spacing: 8) {
            LabelCC(.titlePrimary, "Primary Title")
            LabelCC(.bodyPrimary, "Primary Body")
            LabelCC(.captionPrimary, "Primary Caption")
            LabelCC(.bodySecondary, "Secondary Body")
        }
        .padding(16)
    }
}

#Preview("Custom") {
    ZStack {
        Color.black.ignoresSafeArea()

        VStack(alignment: .leading, spacing: 10) {
            LabelCC("Alert Status", font: Fonts.title2, color: Color.Cc.cyan)
            LabelCC("Subsystem Online", font: Fonts.headline, color: Color.Cc.crimsonMid)
            LabelCC("Calibration Pending", font: Fonts.callout, color: Color.Cc.cyanMid)
        }
        .padding(16)
    }
}

#Preview("Multiline") {
    ZStack {
        Color.black.ignoresSafeArea()

        VStack(alignment: .leading, spacing: 12) {
            LabelCC(
                .bodyPrimary,
                "Awaiting telemetry handshake. Please verify uplink integrity and retry within the next cycle."
            )
            .frame(maxWidth: 240, alignment: .leading)

            LabelCC(
                .bodySecondary,
                "Secondary channel is now monitoring fallback systems while diagnostics complete."
            )
            .frame(maxWidth: 240, alignment: .leading)
        }
        .padding(16)
    }
}
