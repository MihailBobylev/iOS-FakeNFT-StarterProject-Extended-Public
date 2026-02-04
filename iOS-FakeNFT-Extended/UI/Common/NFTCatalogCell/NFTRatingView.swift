//
//  NFTRaitingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 24.01.2026.
//

import SwiftUI

struct NFTRatingView: View {
    private let maxRating = 5
    let rating: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(
                    index <= rating
                    ? .icStarSelected
                    : .icStarUnselected
                )
                .renderingMode(.original)
            }
        }
    }
}

#Preview {
    NFTRatingView(rating: 3)
}
