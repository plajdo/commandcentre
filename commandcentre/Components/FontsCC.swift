//
//  FontsCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import SwiftUI
import UIKit

enum Fonts {

    private static let fontRajdhaniMedium = "Rajdhani-Medium"

    private static func customFont(size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        Font.custom(fontRajdhaniMedium, size: size, relativeTo: textStyle)
    }

    static let largeTitle = customFont(size: 34, relativeTo: .largeTitle)
    static let title = customFont(size: 28, relativeTo: .title)
    static let title2 = customFont(size: 22, relativeTo: .title2)
    static let title3 = customFont(size: 20, relativeTo: .title3)
    static let headline = customFont(size: 17, relativeTo: .headline)
    static let body = customFont(size: 17, relativeTo: .body)
    static let callout = customFont(size: 16, relativeTo: .callout)
    static let subheadline = customFont(size: 15, relativeTo: .subheadline)
    static let footnote = customFont(size: 13, relativeTo: .footnote)
    static let caption1 = customFont(size: 12, relativeTo: .caption)
    static let caption2 = customFont(size: 11, relativeTo: .caption2)

}
