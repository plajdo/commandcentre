//
//  MainScreenViewModel.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import GoodCoordinator
import GoodReactor
import Observation

@Observable final class MainScreenViewModel: Reactor {

    typealias Event = GoodReactor.Event<Action, Mutation, Destination>

    // MARK: - Action

    enum Action {

        case buttonTapped

    }

    // MARK: - Mutation

    enum Mutation { }

    // MARK: - State

    @MainActor @Observable final class State { }

    // MARK: - Destination

    @Navigable enum Destination {

        case calendar
        case quicknote

    }

    // MARK: - Lifecycle

    func makeInitialState() -> State {
        return State()
    }

    // MARK: - Reduce

    func reduce(state: inout State, event: Event) {
        switch event.kind {
        case .action(.buttonTapped):
            break

        default:
            break
        }
    }

}
