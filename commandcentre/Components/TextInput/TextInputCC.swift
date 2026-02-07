//
//  TextInputCC.swift
//  commandcentre
//
//  Created by Filip Šašala on 07/02/2026.
//

import SwiftUI

struct TextInputCC: View {

    @Binding private var text: String
    private var isFocused: FocusState<Bool>.Binding

    init(text: Binding<String>, isFocused: FocusState<Bool>.Binding) {
        self._text = text
        self.isFocused = isFocused
    }

    var body: some View {
        TextEditor(text: $text)
            .font(Fonts.body)
            .foregroundStyle(Color.Cc.crimson)
            .focused(isFocused)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .frame(minHeight: 64)
    }

}
