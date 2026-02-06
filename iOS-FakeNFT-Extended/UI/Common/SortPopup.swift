//
//  SortPopup.swift
//  iOS-FakeNFT-Extended
//
//  Created by Dmitry on 06.02.2026.
//

import SwiftUI

struct SortPopup: View {
    private enum Constants {
        static let priceTitle = "По цене"
        static let ratingTitle = "По рейтингу"
        static let nameTitle = "По названию"
        static let closeTitle = "Закрыть"
    }
    
    let currentSort: BasketSortOption
    let onSelect: (BasketSortOption) -> Void
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            Color.ypModalOverlay
                .ignoresSafeArea()
                .onTapGesture { onClose() }
            
            VStack(spacing: 8) {
                Button(Constants.priceTitle) {
                    onSelect(.price)
                }
                Button(Constants.ratingTitle) {
                    onSelect(.rating)
                }
                Button(Constants.nameTitle) {
                    onSelect(.name)
                }
                Button(Constants.closeTitle) {
                    onClose()
                }
            }
            .font(.title3Regular)
            .foregroundColor(.ypBlue)
            .padding()
            .background(Color.ypWhite)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
    }
}

