//
//  QuicknoteViewModel.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import GoodCoordinator
import GoodReactor
import Observation

@Observable final class QuicknoteViewModel: Reactor {

    typealias Event = GoodReactor.Event<Action, Mutation, Destination>

    // MARK: - Action

    enum Action {

        case setNoteText(String)

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

        default:
            break
        }
    }

}
