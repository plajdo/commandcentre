//
//  BatteryView.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import SwiftUI
import UIKit

struct BatteryView: ViewModifier {

    private let batteryService = BatteryService()

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                TimelineView(.periodic(from: .now, by: 10)) { _ in
                    let level = batteryService.currentBatteryLevel
                    let state = batteryService.currentBatteryState
                    let statusText = batteryStatusText(level: level, state: state)

                    LabelCC(.captionPrimary, statusText)
                        .padding(.leading, 24)
                        .padding(.top, 16)
                        .ignoresSafeArea(.all)
                }
            }
    }

    private func batteryStatusText(level: Double?, state: UIDevice.BatteryState) -> String {
        let percentText = BatteryView.formatBatteryPercent(level)
        let statusText = batteryService.localizedChargingState(state)

        return "BATTERY \(percentText) \(statusText)"
    }

    private static func formatBatteryPercent(_ level: Double?) -> String {
        guard let level else {
            return "N/A%"
        }

        let percentage = Int((level * 100.0).rounded())
        return "\(percentage)%"
    }

}
