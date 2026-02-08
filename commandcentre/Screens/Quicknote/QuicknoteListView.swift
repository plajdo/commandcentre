//
//  QuicknoteListView.swift
//  commandcentre
//
//  Created by Filip Šašala on 08/02/2026.
//

import GoodReactor
import SwiftUI

struct QuicknoteListView: View {

    // MARK: - View model

    @ViewModel var viewModel: AnyReactor<QuicknoteListViewModel.Action, QuicknoteListViewModel.Destination, QuicknoteListViewModel.State>

    // MARK: - Initialization

    init() {
        self._viewModel = ViewModel(initialValue: QuicknoteListViewModel().eraseToAnyReactor())
    }

    init(viewModel: AnyReactor<QuicknoteListViewModel.Action, QuicknoteListViewModel.Destination, QuicknoteListViewModel.State>) {
        self._viewModel = ViewModel(initialValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        content
            .background { BackgroundCC() }
            .onFirstAppear {
                viewModel.start()
                viewModel.send(action: .load)
            }
    }

}

// MARK: - Content

private extension QuicknoteListView {

    var content: some View {
        ScrollView {
            VStack {
                WidgetCC(title: "QUICKNOTES") {
                    quicknotesSection
                }
                .padding(16)

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

// MARK: - Quicknotes

private extension QuicknoteListView {

    @ViewBuilder var quicknotesSection: some View {
        if viewModel.quicknotes.isEmpty {
            LabelCC(.bodySecondary, "No quicknotes available.")

            Spacer()
                .frame(height: 48)
        } else {
            ForEach(viewModel.quicknotes, id: \.id) { quicknote in
                quicknoteRow(for: quicknote)
            }
        }
    }

    func quicknoteRow(for quicknote: Quicknote) -> some View {
        VStack(spacing: 2) {
            let date = CommandCentreDateFormatter.dateString(from: quicknote.createdAt)
            let time = CommandCentreDateFormatter.timeString(from: quicknote.createdAt)
            LabelCC(.captionPrimary, "\(date) \(time)")
            ChipCC(style: .primary, isTopInsetEnabled: false) {
                Text(String(quicknote.noteText))
                    .foregroundStyle(Color.Cc.crimsonMid)
                    .font(Fonts.body)
            }
        }
    }

}

// MARK: - Previews

#Preview("Empty") {
    QuicknoteListView(
        viewModel: Stub<QuicknoteListViewModel> {
            QuicknoteListViewModel.State()
        }.eraseToAnyReactor()
    )
}

#Preview("Success") {
    QuicknoteListView(
        viewModel: Stub<QuicknoteListViewModel> {
            let state = QuicknoteListViewModel.State()
            state.quicknotes = [
                Quicknote(
                    id: "preview-1",
                    noteText: "Stabilizer check complete.",
                    createdAt: Date(timeIntervalSince1970: 1_738_480_800)
                ),
                Quicknote(
                    id: "preview-2",
                    noteText: "Diagnostics queued for sector grid.",
                    createdAt: Date(timeIntervalSince1970: 1_738_484_200)
                ),
                Quicknote(
                    id: "preview-3",
                    noteText: "Fuel pressure nominal across all lines.",
                    createdAt: Date(timeIntervalSince1970: 1_738_487_600)
                )
            ]
            return state
        }.eraseToAnyReactor()
    )
}
