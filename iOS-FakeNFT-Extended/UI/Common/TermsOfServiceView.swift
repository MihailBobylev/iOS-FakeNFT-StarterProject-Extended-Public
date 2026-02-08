//
//  TermsOfServiceView.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) private var dismiss
    
    private enum Constants {
        static let navigationTitle = "Пользовательское соглашение"
        static let termsURLString = "https://yandex.ru/legal/practicum_termsofuse"
    }
    
    var body: some View {
        Group {
            if let url = URL(string: Constants.termsURLString) {
                WebView(url: url)
            } else {
                Text("Ошибка загрузки")
                    .foregroundColor(.ypBlack)
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TermsOfServiceView()
    }
}
