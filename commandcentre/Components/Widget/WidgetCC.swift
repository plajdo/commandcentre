//
//  WidgetCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

// MARK: - Widget

struct WidgetCC<Content: View>: View {

    private let title: String
    private let layout: WidgetCC.LayoutConfiguration
    private let content: () -> Content

    init(
        title: String,
        layout: WidgetCC.LayoutConfiguration = .oneColumn,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.layout = layout
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            header
                .padding(.all, 8)

            Rectangle()
                .fill(Color.Cc.crimsonMid)
                .frame(height: 1)

            contentGrid
                .padding(.vertical, 8)

            Rectangle()
                .fill(Color.Cc.crimsonDark)
                .frame(height: 1)
                .padding(.top, 24)
        }
    }

}

// MARK: - Layout configuration

extension WidgetCC {

    enum LayoutConfiguration {

        case oneColumn
        case twoColumns

    }

}

// MARK: - Content

private extension WidgetCC {

    var header: some View {
        Text(String(title.uppercased()))
            .font(Fonts.largeTitle)
            .foregroundStyle(Color.Cc.crimson)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    var contentGrid: some View {
        LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 8) {
            content()
        }
    }

    var gridColumns: [GridItem] {
        switch layout {
        case .oneColumn:
            return [GridItem(.flexible())]
        case .twoColumns:
            return [
                GridItem(.flexible(), spacing: 2),
                GridItem(.flexible(), spacing: 2)
            ]
        }
    }

}

// MARK: - Previews

#Preview("One Column") {
    ZStack {
        Color.black.ignoresSafeArea()

        WidgetCC(title: "Actions") {
            ButtonCC(image: Image(systemName: "shield.lefthalf.filled"), text: "BUTTON 1") { }
            ButtonCC(image: Image(systemName: "shield.lefthalf.filled"), text: "BUTTON 2") { }
            ButtonCC(image: Image(systemName: "shield.lefthalf.filled"), text: "BUTTON 3") { }
        }
        .padding(16)
    }
}

#Preview("Two Columns") {
    ZStack {
        Color.black.ignoresSafeArea()

        WidgetCC(title: "Systems", layout: .twoColumns) {
            ButtonCC(image: Image(systemName: "desktopcomputer"), text: "SYSTEM 1") { }
            ButtonCC(image: Image(systemName: "desktopcomputer"), text: "SYSTEM 2") { }
            ButtonCC(image: Image(systemName: "desktopcomputer"), text: "SYSTEM 3") { }
            ButtonCC(image: Image(systemName: "desktopcomputer"), text: "SYSTEM 4") { }
        }
        .padding(16)
    }
}
