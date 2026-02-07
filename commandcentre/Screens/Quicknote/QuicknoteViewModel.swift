//
//  QuicknoteViewModel.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import Factory
import Foundation
import GoodCoordinator
import GoodReactor
import Observation

@Observable final class QuicknoteViewModel: Reactor {

    typealias Event = GoodReactor.Event<Action, Mutation, Destination>

    // MARK: - Dependencies

    @ObservationIgnored @Injected(\.databaseService) private var databaseService

    // MARK: - Action

    enum Action {

        case setNoteText(String)
        case saveNoteOnDisappear

    }

    // MARK: - Mutation

    enum Mutation { }

    // MARK: - State

    @MainActor @Observable final class State {

        var noteText = ""

    }

    // MARK: - Destination

    @Navigable enum Destination {

        case none

    }

    // MARK: - Lifecycle

    func makeInitialState() -> State {
        return State()
    }

    // MARK: - Reduce

    func reduce(state: inout State, event: Event) {
        switch event.kind {
        case .action(.setNoteText(let noteText)):
            state.noteText = noteText

        case .action(.saveNoteOnDisappear):
            let trimmedNoteText = state.noteText.trimmingCharacters(in: .whitespacesAndNewlines)

            // Skip saving empty notes
            guard !trimmedNoteText.isEmpty else {
                break
            }

            run(event) {
                do {
                    try await databaseService.saveQuicknote(noteText: trimmedNoteText, createdAt: .now)
                } catch {
                    log(.error, "Quicknote save failed.", metadata(error))
                }
                return nil
            }

        default:
            break
        }
    }

}
