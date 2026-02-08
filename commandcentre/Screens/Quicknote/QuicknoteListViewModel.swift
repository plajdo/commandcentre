//
//  QuicknoteListViewModel.swift
//  commandcentre
//
//  Created by Filip Šašala on 08/02/2026.
//

import Factory
import GoodCoordinator
import GoodReactor
import Observation

@Observable final class QuicknoteListViewModel: Reactor {

    typealias Event = GoodReactor.Event<Action, Mutation, Destination>

    // MARK: - Dependencies

    @ObservationIgnored @Injected(\.databaseService) private var databaseService

    // MARK: - Action

    enum Action {

        case load

    }

    // MARK: - Mutation

    enum Mutation {

        case setQuicknotes([Quicknote])

    }

    // MARK: - State

    @MainActor @Observable final class State {

        var quicknotes: [Quicknote] = []

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
        case .action(.load):
            run(event) {
                do {
                    let quicknotes = try await databaseService.fetchLatestQuicknotes(limit: 5)
                    return Mutation.setQuicknotes(quicknotes)
                } catch {
                    log(.error, "Quicknote fetch failed.", metadata(error))
                    return nil
                }
            }

        case .mutation(.setQuicknotes(let quicknotes)):
            state.quicknotes = quicknotes

        default:
            break
        }
    }

}
