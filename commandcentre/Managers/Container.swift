//
//  Container.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Factory
import UIKit

// MARK: - AutoRegistering

extension Container: @retroactive AutoRegistering {

    public func autoRegister() {
        #if DEBUG
            registerDebugDependencies()
        #else
            registerDependencies()
        #endif
    }

    /// Register mock dependencies in debug builds (e.g. skip certain checks and always return `true`)
    func registerDebugDependencies() {

    }

    /// Register production dependencies
    func registerDependencies() {

    }

}

// MARK: - Services

extension Container {

    var databaseService: Factory<DatabaseService> {
        Factory(self) {
            DatabaseService()
        }.singleton
    }

}
