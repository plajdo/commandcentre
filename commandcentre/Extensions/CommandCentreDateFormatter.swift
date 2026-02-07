//
//  CommandCentreDateFormatter.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Foundation

nonisolated enum CommandCentreDateFormatter {

    static func dateString(from date: Date) -> String {
        return displayDateFormatter.string(from: date)
    }

    static func timeString(from date: Date) -> String {
        return displayTimeFormatter.string(from: date)
    }

    static func zoneString(from date: Date) -> String {
        let formattedText = displayZoneFormatter.string(from: date)
        return "W\(formattedText)"
    }

}

// MARK: - Helpers

private extension CommandCentreDateFormatter {

    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()

    static let displayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }()

    static let displayZoneFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "wwQQQ ZZZZ"
        return formatter
    }()

}
