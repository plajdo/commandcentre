//
//  ChipCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import SwiftUI

// MARK: - Chip

struct ChipCC<Content: View>: View {

    private let title: String?
    private let style: Style
    private let content: () -> Content

    init(
        title: String? = nil,
        style: Style,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            if let title {
                Text(String(title.uppercased()))
                    .font(Fonts.largeTitle)
                    .foregroundStyle(style.color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(style.midColor)
            }

            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
        }
        .clipShape(ChipCCFrameShape().inset(by: 0.5))
        .overlay {
            ChipCCFrameShape()
                .strokeBorder(style.color, lineWidth: 1)
        }
        .overlay(alignment: .leading) {
            ChipCCLeadingBar()
                .fill(style.color)
                .frame(width: 6)
        }
        .contentShape(ChipCCFrameShape())
    }

}

// MARK: - Style

extension ChipCC {

    enum Style {

        case primary
        case secondary
        case info
        case important

        var color: Color {
            switch self {
            case .primary:
                return Color.Cc.crimson
            case .secondary:
                return Color.Cc.cyan
            case .info:
                return Color.Cc.green
            case .important:
                return Color.Cc.gold
            }
        }

        var midColor: Color {
            switch self {
            case .primary:
                return Color.Cc.crimsonMid
            case .secondary:
                return Color.Cc.cyanMid
            case .info:
                return Color.Cc.greenMid
            case .important:
                return Color.Cc.goldMid
            }
        }

    }

}

// MARK: - Shapes

private struct ChipCCFrameShape: InsettableShape {

    private var insetAmount: CGFloat = 0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }

    func path(in rect: CGRect) -> Path {
        let adjustedRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let topCut = min(adjustedRect.height * 0.18, 5)
        let topInset = adjustedRect.height + (topCut * 0.5)
        let trailingCut = min(adjustedRect.height * 0.28, 12)

        var path = Path()
        path.move(to: CGPoint(x: adjustedRect.minX, y: adjustedRect.minY))
        path.addLine(to: CGPoint(x: adjustedRect.minX, y: adjustedRect.maxY))
        path.addLine(to: CGPoint(x: adjustedRect.maxX - trailingCut, y: adjustedRect.maxY))
        path.addLine(to: CGPoint(x: adjustedRect.maxX, y: adjustedRect.maxY - trailingCut))
        path.addLine(to: CGPoint(x: adjustedRect.maxX, y: adjustedRect.minY + topCut))
        path.addLine(to: CGPoint(x: adjustedRect.minX + topInset, y: adjustedRect.minY + topCut))
        path.addLine(to: CGPoint(x: adjustedRect.minX + topInset - topCut, y: adjustedRect.minY))
        path.closeSubpath()

        return path
    }

}

private struct ChipCCLeadingBar: Shape {

    func path(in rect: CGRect) -> Path {
        let dent = min(rect.height * 0.06, 1)

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + dent, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + dent, y: rect.maxY - dent))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - dent))
        path.closeSubpath()

        return path
    }

}

// MARK: - Previews

#Preview("Primary") {
    ZStack {
        Color.black.ignoresSafeArea()

        ChipCC(title: "Training", style: .secondary) {
            Text("To continue training, select a training module.")
                .font(Fonts.body)
                .foregroundStyle(Color.Cc.gold)
        }
        .padding(16)
    }
}

#Preview("Info") {
    ZStack {
        Color.black.ignoresSafeArea()

        ChipCC(style: .info) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Status")
                    .font(Fonts.headline)
                    .foregroundStyle(Color.Cc.green)
                Text("Telemetry link verified.")
                    .font(Fonts.body)
                    .foregroundStyle(Color.Cc.cyanMid)
            }
        }
        .padding(16)
    }
}
