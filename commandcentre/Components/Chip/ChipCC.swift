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
    private let isTopInsetEnabled: Bool
    private let content: () -> Content

    init(
        title: String? = nil,
        style: Style,
        isTopInsetEnabled: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.style = style
        self.isTopInsetEnabled = isTopInsetEnabled
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            if let title {
                Text(String(title.uppercased()))
                    .font(Fonts.title2)
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
        .clipShape(ChipCCFrameShape(isTopInsetEnabled: isTopInsetEnabled).inset(by: 0.5))
        .overlay {
            ChipCCFrameShape(isTopInsetEnabled: isTopInsetEnabled)
                .strokeBorder(style.color, lineWidth: 1)
        }
        .overlay(alignment: .leading) {
            ChipCCLeadingBarShape()
                .fill(style.color)
                .frame(width: 6)
                .offset(x: -6)
        }
        .contentShape(ChipCCFrameShape(isTopInsetEnabled: isTopInsetEnabled))
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

// MARK: - Chip shape

struct ChipCCFrameShape: InsettableShape {

    private let isTopInsetEnabled: Bool
    private var insetAmount: CGFloat = 0

    init(isTopInsetEnabled: Bool) {
        self.isTopInsetEnabled = isTopInsetEnabled
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }

    func path(in rect: CGRect) -> Path {
        let adjustedRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        let topCut = isTopInsetEnabled ? min(adjustedRect.height * 0.18, 5) : 0
        let topInset = min(adjustedRect.height + (topCut * 0.5), adjustedRect.width)
        let trailingCut = min(adjustedRect.height * 0.28, 12)
        let topInsetX = isTopInsetEnabled ? adjustedRect.minX + topInset : adjustedRect.maxX

        var path = Path()
        path.move(to: CGPoint(x: adjustedRect.minX, y: adjustedRect.minY))
        path.addLine(to: CGPoint(x: adjustedRect.minX, y: adjustedRect.maxY))
        path.addLine(to: CGPoint(x: adjustedRect.maxX - trailingCut, y: adjustedRect.maxY))
        path.addLine(to: CGPoint(x: adjustedRect.maxX, y: adjustedRect.maxY - trailingCut))
        path.addLine(to: CGPoint(x: adjustedRect.maxX, y: adjustedRect.minY + topCut))
        path.addLine(to: CGPoint(x: topInsetX, y: adjustedRect.minY + topCut))
        path.addLine(to: CGPoint(x: topInsetX - topCut, y: adjustedRect.minY))
        path.closeSubpath()

        return path
    }

}

// MARK: - Leading bar

struct ChipCCLeadingBarShape: Shape {

    func path(in rect: CGRect) -> Path {
        let dentTop = rect.height * 0.58
        let dentBottom = rect.height * 0.85

        let dentSize = dentSize(for: rect.height)

        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: dentBottom))
        path.addLine(to: CGPoint(x: rect.minX + dentSize, y: dentBottom - dentSize))
        path.addLine(to: CGPoint(x: rect.minX + dentSize, y: dentTop + dentSize))
        path.addLine(to: CGPoint(x: rect.minX, y: dentTop))
        path.closeSubpath()

        return path
    }

    private func dentSize(for height: CGFloat) -> CGFloat {
        let minHeight: CGFloat = 50
        let maxHeight: CGFloat = 150
        let minDent: CGFloat = 2
        let maxDent: CGFloat = 1

        if height <= minHeight {
            return minDent
        }

        if height >= maxHeight {
            return maxDent
        }

        let progress = (height - minHeight) / (maxHeight - minHeight)
        return minDent + (maxDent - minDent) * progress
    }

}

// MARK: - Previews

#Preview("Header") {
    ZStack {
        Color.black.ignoresSafeArea()

        ChipCC(title: "Training", style: .secondary, isTopInsetEnabled: true) {
            Text("To continue training, select a training module.")
                .font(Fonts.body)
                .foregroundStyle(Color.Cc.gold)
        }
        .padding(16)
    }
}

#Preview("No header") {
    ZStack {
        Color.black.ignoresSafeArea()

        ChipCC(style: .info, isTopInsetEnabled: false) {
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
