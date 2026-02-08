//
//  CalendarViewModel.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import GoodCoordinator
import GoodReactor
import Observation

@Observable final class CalendarViewModel: Reactor {

    typealias Event = GoodReactor.Event<Action, Mutation, Destination>

    // MARK: - Action

    enum Action {

        case load

    }

    // MARK: - Mutation

    enum Mutation { }

    // MARK: - State

    @MainActor @Observable final class State { }

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
        case .action(.load):
            break

        default:
            break
        }
    }

}
