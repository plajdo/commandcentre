//
//  CCLogger.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Factory
import Foundation
import GoodNetworking
import Pulse

public typealias LogMetadata = [String: String]

// MARK: - Global log function

nonisolated public func log(_ level: CCLogLevel, _ message: String, _ metadata: LogMetadata? = nil, file: String = #file, function: String = #function, line: UInt = #line) {
    Container.shared.logger().log(level: level, message: message, metadata: metadata, file: file, function: function, line: line)
}

nonisolated public func metadata(_ value: Any) -> LogMetadata {
    let description: String
    if let convertible = value as? CustomStringConvertible {
        description = convertible.description
    } else {
        description = String(describing: value)
    }
    return ["obj": description]
}

// MARK: - Logger

// Has raw values for interoperability with SwiftLog.Logger.Level / Pulse.LoggerStore.Level
public enum CCLogLevel: Int16 {

    case trace = 1
    case debug = 2
    case info = 3
    case notice = 4
    case warning = 5
    case error = 6
    case critical = 7

}

struct CCLogger {

    func log(
        level: CCLogLevel,
        message: String,
        metadata: LogMetadata?,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        let convertedMetadata = metadata?.reduce(into: [String: LoggerStore.MetadataValue]()) { dictionary, entry in
            dictionary[entry.key] = .stringConvertible(entry.value)
        }

        LoggerStore.shared.storeMessage(
            createdAt: .now,
            label: (file as NSString).lastPathComponent,
            level: LoggerStore.Level(rawValue: level.rawValue) ?? .debug,
            message: message,
            metadata: convertedMetadata ?? [:],
            file: file,
            function: function,
            line: line
        )
    }

}

// MARK: - Factory

extension Container {

    var logger: Factory<CCLogger> {
        Factory(self) {
            CCLogger()
        }.singleton
    }

}
