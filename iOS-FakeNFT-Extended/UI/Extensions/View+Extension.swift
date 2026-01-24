//
//  View+Extension.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 22.01.2026.
//

import SwiftUI

struct SortOption: Identifiable {
    let id = UUID()
    let title: String
    let role: ButtonRole?
    let action: () -> Void
    
    init(
        title: String,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.role = role
        self.action = action
    }
}

struct SortConfirmationDialog {
    let title: String
    let options: [SortOption]
}

extension View {
    func sortDialog(
        isPresented: Binding<Bool>,
        dialog: SortConfirmationDialog,
        cancelButtonTitle: String
    ) -> some View {
        confirmationDialog(
            dialog.title,
            isPresented: isPresented,
            titleVisibility: .visible
        ) {
            ForEach(dialog.options) { option in
                Button(option.title, role: option.role, action: option.action)
            }

            Button(cancelButtonTitle, role: .cancel) { }
        }
    }
}
