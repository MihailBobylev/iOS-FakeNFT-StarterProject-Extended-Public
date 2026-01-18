//
//  MyNFTDescriptionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct FavoriteNFTDescriptionView: View {
    var viewModel: FavoriteNFTViewModel
    private let maxRating: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.name)
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
            HStack(spacing: 4) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(index <= viewModel.rating ? "ic_star_selected" : "ic_star_unselected")
                        .foregroundStyle(index <= viewModel.rating ? .ypYellow : .ypLightGray)
                }
            }
            Text("\(viewModel.price.formatted(.number.precision(.fractionLength(2)))) ETH")
                .font(.footnoteRegular15)
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    let model = FavoriteNFTModel(
        name: "Archie",
        rating: 1,
        price: 1.78,
        isLiked: true
    )
    let viewModel = FavoriteNFTViewModel(model: model)
    FavoriteNFTDescriptionView(viewModel: viewModel)
}
