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

    static let buttonIcon = Font.custom(fontRajdhaniMedium, size: 22)
    static let buttonTitle = Font.custom(fontRajdhaniMedium, size: 34)
    static let debugMenuButton = Font.custom(
        fontRajdhaniMedium,
        size: UIFont.preferredFont(forTextStyle: .title2).pointSize,
        relativeTo: .title2
    )

}
