//
//  MainView.swift
//  commandcentre
//
//  Created by Filip Šašala on 06/02/2026.
//

import GoodCoordinator
import GoodReactor
import SwiftUI

struct MainView: View {

    // MARK: - View model

    @ViewModel var viewModel: AnyReactor<MainViewModel.Action, MainViewModel.Destination, MainViewModel.State>

    // MARK: - Initialization

    init() {
        self._viewModel = ViewModel(initialValue: MainViewModel().eraseToAnyReactor())
    }

    init(viewModel: AnyReactor<MainViewModel.Action, MainViewModel.Destination, MainViewModel.State>) {
        self._viewModel = ViewModel(initialValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        content
            .navigationDestination(isPresented: $viewModel.destination.calendar) {
                CalendarView()
            }
            .navigationDestination(isPresented: $viewModel.destination.quicknote) {
                QuicknoteView()
            }
            .toolbar(.hidden, for: .navigationBar)
            .onFirstAppear {
                viewModel.start()
            }
    }

}

// MARK: - Content

private extension MainView {

    var content: some View {
        VStack {
            WidgetCC(title: "CONTROL CENTRE") {
                LabelCC(.captionPrimary, systemInfoText)

                TimelineView(.animation(minimumInterval: 0.111)) { context in
                    let dateText = CommandCentreDateFormatter.dateString(from: context.date)
                    let timeText = CommandCentreDateFormatter.timeString(from: context.date)
                    let zoneText = CommandCentreDateFormatter.zoneString(from: context.date)

                    LabelCC(.captionPrimary, "DATE: \(dateText)")
                    LabelCC(.captionPrimary, "TIME: \(timeText)")
                    LabelCC(.captionPrimary, "ZONE: \(zoneText)")
                }

//                LabelCC(.bodySecondary, "General info available.")

                Spacer()
                    .frame(height: 48)

                ButtonCC(image: Image(systemName: "calendar"), text: "Calendar") {
                    viewModel.send(destination: .calendar)
                }

                ButtonCC(image: Image(systemName: "square.and.pencil"), text: "Quicknote") {
                    viewModel.send(destination: .quicknote)
                }
            }
            .padding(16)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

// MARK: - Helpers

private extension MainView {

    var systemInfoText: String {
        let info = SystemInfo.getInfo()

        return "SYSTEM \(info.systemVersion) \(info.modelIdentifier) BUILD \(info.buildNumber)".uppercased()
    }

}

// MARK: - Previews

#Preview("Default") {
    MainView()
}

#Preview("Success") {
    MainView()
}
