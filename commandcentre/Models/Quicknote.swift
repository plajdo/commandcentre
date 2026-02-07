//
//  Quicknote.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Foundation
import GRDB

struct Quicknote: Codable, FetchableRecord, PersistableRecord, TableRecord {

    static let databaseTableName = "quicknotes"

    let id: String
    let noteText: String
    let createdAt: Date

    enum Columns: String, ColumnExpression {

        case id
        case noteText
        case createdAt

    }

}
