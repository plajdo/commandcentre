//
//  CommandCentreApp.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

@main
struct CommandCentreApp: App {
    @State private var isDebugMenuPresented = false

    var body: some Scene {
        WindowGroup {
            AppSceneRouter()
                .modifier(DebugMenuModifier(isPresented: $isDebugMenuPresented))
        }
    }
}
