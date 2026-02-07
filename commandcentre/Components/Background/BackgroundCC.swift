//
//  BackgroundCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import SwiftUI

// MARK: - Background

struct BackgroundCC: View {

    @State private var startDate = Date()

    var body: some View {
        TimelineView(.animation) { context in
            let time = context.date.timeIntervalSince(startDate)

            RadialGradient(
                gradient: Gradient(colors: [
                    Color.Cc.crimsonMid,
                    Color.Cc.crimson.opacity(0)
                ]),
                center: UnitPoint(x: 0.5, y: 1.35),
                startRadius: 0,
                endRadius: 650 // size.height * 0.75
            )
            .colorEffect(pulseShader(time: time))
            .ignoresSafeArea()
            .allowsHitTesting(false)
        }
    }

}

private extension BackgroundCC {

    func pulseShader(time: TimeInterval) -> Shader {
        let timeValue = Float(time * 0.5)
        let pulseAmplitude = Float(0.04)
        let ditherAmount = Float(1.0 / 255.0)
        let ditherSpeed = Float(0.35)

        return Shader(
            function: ShaderFunction(library: .default, name: "backgroundPulse"),
            arguments: [
                .float(timeValue),
                .float(pulseAmplitude),
                .float(ditherAmount),
                .float(ditherSpeed)
            ]
        )
    }

}

// MARK: - Previews

#Preview("Default") {
    ZStack {
        Color.black.ignoresSafeArea()

        BackgroundCC()
    }
}

#Preview("With Content") {
    ZStack {
        Color.black.ignoresSafeArea()

        TabView {
            VStack {
                Spacer()

                WidgetCC(title: "Actions") {
                    ButtonCC(image: Image(systemName: "shield.lefthalf.filled"), text: "BUTTON 1") { }
                    ButtonCC(image: Image(systemName: "shield.lefthalf.filled"), text: "BUTTON 2") { }
                }
                .padding(16)

                Spacer()
            }
            .background {
                BackgroundCC()
            }
            .tabItem {
                Label(String("Main"), systemImage: "circle.grid.2x2")
            }

            VStack {
                Spacer()

                WidgetCC(title: "Settings") {
                    ButtonCC(image: Image(systemName: "gearshape.fill"), text: "BUTTON 1") { }
                    ButtonCC(image: Image(systemName: "gearshape.fill"), text: "BUTTON 2") { }
                }
                .padding(16)

                Spacer()
            }
            .background {
                BackgroundCC()
            }
            .tabItem {
                Label(String("Settings"), systemImage: "gearshape")
            }
        }
    }
}
