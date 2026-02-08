//
//  SystemInfo.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Foundation
import UIKit

struct SystemInfo {

    let systemVersion: String
    let modelIdentifier: String
    let buildNumber: String

    static func getInfo() -> SystemInfo {
        let systemVersion = UIDevice.current.systemVersion
        let modelIdentifier = SystemInfo.resolveModelIdentifier()
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "—"

        return SystemInfo(
            systemVersion: systemVersion,
            modelIdentifier: modelIdentifier,
            buildNumber: buildNumber
        )
    }

    private static func resolveModelIdentifier() -> String {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)

        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)

        let identifier = String(cString: machine)

        if identifier == "x86_64" || identifier == "arm64" {
            if let simulatedIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
                return simulatedIdentifier
            }
        }

        if identifier.isEmpty {
            return "Unknown"
        }

        return identifier
    }

}
