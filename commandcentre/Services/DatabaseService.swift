//
//  DatabaseService.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Foundation
import GRDB

// MARK: - Database service

final class DatabaseService: Sendable {

    private let databaseQueue: DatabaseQueue

    // MARK: - Migrations

    private let migrator: DatabaseMigrator = {
        var migrator = DatabaseMigrator()
        migrator.registerMigration("v1_create_quicknotes") { database in
            try database.create(table: Quicknote.databaseTableName) { table in
                table.column(Quicknote.Columns.id.name, .text).primaryKey()
                table.column(Quicknote.Columns.noteText.name, .text).notNull()
                table.column(Quicknote.Columns.createdAt.name, .datetime).notNull()
            }
        }
        return migrator
    }()

    // MARK: - Initialization

    init() {
        let databaseURL = DatabaseService.makeDatabaseURL()
        let configuration = Configuration()

        do {
            self.databaseQueue = try DatabaseQueue(path: databaseURL.path, configuration: configuration)
            try migrator.migrate(databaseQueue)
            log(.info, "Database initialized.")
        } catch {
            log(.critical, "Database setup failed.", metadata(error))
            fatalError("Database setup failed.")
        }
    }

    private static func makeDatabaseURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let directoryURL = documentsDirectory.first else {
            log(.critical, "Documents directory not available.")
            fatalError("Documents directory not available.")
        }
        return directoryURL.appendingPathComponent("commandcentre.sqlite")
    }

}

// MARK: - Quicknote

extension DatabaseService {

    func saveQuicknote(noteText: String, createdAt: Date) throws {
        let quicknote = Quicknote(
            id: UUID().uuidString,
            noteText: noteText,
            createdAt: createdAt
        )

        try databaseQueue.write { database in
            try quicknote.insert(database)
        }
        log(.info, "Quicknote saved.")
    }

}
