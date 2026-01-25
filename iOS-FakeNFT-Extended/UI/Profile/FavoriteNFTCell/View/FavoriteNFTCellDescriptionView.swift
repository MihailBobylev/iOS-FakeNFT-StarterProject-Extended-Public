//
//  FavoriteNFTCellDescriptionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct FavoriteNFTCellDescriptionView: View {
    @Binding var viewModel: FavoriteNFTCellViewModel
    private let maxRating: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.model.name)
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
            HStack(spacing: 4) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(index <= viewModel.model.rating ? "ic_star_selected" : "ic_star_unselected")
                        .foregroundStyle(index <= viewModel.model.rating ? .ypYellow : .ypLightGray)
                }
            }
            Text("\(viewModel.model.price.formatted(.number.precision(.fractionLength(2)))) ETH")
                .font(.footnoteRegular15)
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = FavoriteNFTCellViewModel(
        model: FavoriteNFTCellModel(
            name: "Archie",
            rating: 1,
            price: 1.78,
            isLiked: true
        )
    )
    FavoriteNFTCellDescriptionView(viewModel: $viewModel)
}
