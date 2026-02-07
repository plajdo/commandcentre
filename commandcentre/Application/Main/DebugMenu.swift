//
//  DebugMenu.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import SwiftUI

#if DEBUG
import Pulse
import PulseProxy
import PulseUI

struct DebugMenuModifier: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "ladybug")
                        .padding(8)
                }
                .accessibilityLabel("Open Debug Menu")
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    DebugMenuView()
                }
            }
            .task {
                NetworkLogger.enableProxy()
            }
    }
}

private struct DebugMenuView: View {
    var body: some View {
        List {
            NavigationLink("Pulse Console") {
                ConsoleView(store: .shared)
            }
        }
        .navigationTitle("Debug")
    }
}
#else
struct DebugMenuModifier: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        content
    }
}
#endif
