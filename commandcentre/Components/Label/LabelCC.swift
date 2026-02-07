//
//  LabelCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

struct LabelCC: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
    }
}
