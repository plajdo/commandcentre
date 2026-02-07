//
//  AppSceneRouter.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import GoodCoordinator
import GoodReactor
import SwiftUI

@NavigationRoot struct AppSceneRouter: View {

    // MARK: - View model

    @ViewModel private var viewModel = AppSceneRouterModel()

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            switch viewModel.destination {
            case .main:
                NavigationStack {
                    MainScreen()
                }
                .transition(.opacity)

            default:
                Text(String(describing: viewModel.destination))
            }
        }
        .animation(.smooth, value: viewModel.destination)
    }

}
