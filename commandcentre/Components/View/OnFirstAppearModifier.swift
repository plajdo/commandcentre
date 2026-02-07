//
//  OnFirstAppearModifier.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

struct FirstAppearModifier: ViewModifier {

    let action: () -> Void

    // Use this to only fire your block one time
    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}

public extension View {

    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }
}
