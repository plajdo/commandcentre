//
//  QuicknoteView.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import GoodReactor
import SwiftUI

struct QuicknoteView: View {

    // MARK: - View model

    @ViewModel var viewModel: AnyReactor<QuicknoteViewModel.Action, QuicknoteViewModel.Destination, QuicknoteViewModel.State>

    // MARK: - Focus

    @FocusState private var isTextInputFocused: Bool

    // MARK: - Initialization

    init() {
        self._viewModel = ViewModel(initialValue: QuicknoteViewModel().eraseToAnyReactor())
    }

    init(viewModel: AnyReactor<QuicknoteViewModel.Action, QuicknoteViewModel.Destination, QuicknoteViewModel.State>) {
        self._viewModel = ViewModel(initialValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        content
            .background { BackgroundCC() }
            .onFirstAppear {
                viewModel.start()
                isTextInputFocused = true
            }
    }

}

// MARK: - Content

private extension QuicknoteView {

    var content: some View {
        VStack {
            WidgetCC(title: "QUICKNOTE") {
                let noteBinding = viewModel.bind(\.noteText, action: { .setNoteText($0) })

                TextInputCC(text: noteBinding, isFocused: $isTextInputFocused)
            }
            .padding(16)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

// MARK: - Previews

#Preview("Default") {
    QuicknoteView()
}
