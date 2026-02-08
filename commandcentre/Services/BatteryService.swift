//
//  BatteryService.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import UIKit

struct BatteryService {

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    var currentBatteryLevel: Double? {
        BatteryService.normalizedBatteryLevel(UIDevice.current.batteryLevel)
    }

    var currentBatteryState: UIDevice.BatteryState {
        UIDevice.current.batteryState
    }

    func localizedChargingState(_ state: UIDevice.BatteryState) -> String {
        switch state {
        case .unknown:
            return "ERROR"
        case .unplugged:
            return "DISCHARGING"
        case .charging:
            return "CHARGING"
        case .full:
            return "POWER ADAPTER"
        @unknown default:
            return "ERROR"
        }
    }

    private static func normalizedBatteryLevel(_ level: Float) -> Double? {
        guard level >= 0 else {
            return nil
        }

        let clamped = min(max(Double(level), 0.0), 1.0)
        return clamped
    }

}
