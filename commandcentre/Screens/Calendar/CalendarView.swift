//
//  CalendarView.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import GoodReactor
import SwiftUI

struct CalendarView: View {

    // MARK: - View model

    @ViewModel var viewModel: AnyReactor<CalendarViewModel.Action, CalendarViewModel.Destination, CalendarViewModel.State>

    // MARK: - Initialization

    init() {
        self._viewModel = ViewModel(initialValue: CalendarViewModel().eraseToAnyReactor())
    }

    init(viewModel: AnyReactor<CalendarViewModel.Action, CalendarViewModel.Destination, CalendarViewModel.State>) {
        self._viewModel = ViewModel(initialValue: viewModel)
    }

    // MARK: - Body

    var body: some View {
        content
            .onFirstAppear {
                viewModel.start()
                viewModel.send(action: .load)
            }
    }

}

// MARK: - Content

private extension CalendarView {

    var content: some View {
        VStack {
            WidgetCC(title: "CALENDAR") {
                LabelCC(.bodySecondary, "No calendar data available.")

                Spacer()
                    .frame(height: 48)
            }
            .padding(16)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

// MARK: - Previews

#Preview("Default") {
    CalendarView()
}

#Preview("Success") {
    CalendarView()
}
