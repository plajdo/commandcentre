//
//  AppSceneRouterModel.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import Foundation
import GoodCoordinator
import GoodReactor
import Observation

@Observable final class AppSceneRouterModel: Reactor {

    typealias Event = GoodReactor.Event<Action, Mutation, Destination>

    // MARK: - Action

    enum Action { }

    // MARK: - Mutation

    enum Mutation { }

    // MARK: - State

    @MainActor @Observable final class State { }

    // MARK: - Destination

    @Navigable enum Destination: Tabs {

        static var initialDestination: AppSceneRouterModel.Destination = .main

        case main

    }

    // MARK: - Lifecycle

    func makeInitialState() -> State {
        return State()
    }

    // MARK: - Reduce

    func reduce(state: inout State, event: Event) {

    }

}
