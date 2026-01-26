//
//  MultilineTextFieldView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import SwiftUI

struct MultilineTextFieldView: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $text)
                .frame(minHeight: 100, maxHeight: 100)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 100)
                        .foregroundStyle(.ypLightGray)
                )
                .scrollContentBackground(.hidden)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.ypLightSecondary)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 8)
                    .allowsHitTesting(false)
            }
        }
    }
}
#Preview {
    @Previewable @State var text = "Описание"
    MultilineTextFieldView(
        text: $text,
        placeholder: "Введите описание"
    )
}
