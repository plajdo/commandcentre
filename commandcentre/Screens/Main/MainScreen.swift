//
//  MainScreen.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import GoodReactor
import SwiftUI

struct MainScreen: View {

    // MARK: - View model

    @ViewModel var viewModel: AnyReactor<MainScreenViewModel.Action, MainScreenViewModel.Destination, MainScreenViewModel.State>

    // MARK: - Initialization

    init() {
        self._viewModel = ViewModel(initialValue: MainScreenViewModel().eraseToAnyReactor())
    }

    init(viewModel: AnyReactor<MainScreenViewModel.Action, MainScreenViewModel.Destination, MainScreenViewModel.State>) {
        self._viewModel = ViewModel(initialValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        content
            .onFirstAppear {
                viewModel.start()
            }
    }

}

// MARK: - Content

private extension MainScreen {

    var content: some View {
        VStack {
            Spacer()

//            ButtonCC("Main", action: { viewModel.send(action: .buttonTapped) })
//                .padding(.horizontal, 24)

            ButtonCC {
                print("Hello")
            } image: {
                Image(systemName: "shield.lefthalf.filled")
            } text: {
                Text("BUTTON")
            }
            .padding(24)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

// MARK: - Previews

#Preview("Default") {
    MainScreen()
}

#Preview("Success") {
    MainScreen()
}
