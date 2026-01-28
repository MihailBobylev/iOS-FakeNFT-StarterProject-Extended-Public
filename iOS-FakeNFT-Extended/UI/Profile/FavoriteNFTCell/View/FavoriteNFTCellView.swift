//
//  FavoriteNFTCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct FavoriteNFTCellView: View {
    @State var viewModel: FavoriteNFTCellViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            FavoriteNFTCellIconView(viewModel: $viewModel)
            Spacer()
            FavoriteNFTCellDescriptionView(viewModel: $viewModel)
        }
    }
}

#Preview {
    let model = FavoriteNFTCellModel(
        name: "Archie",
        rating: 1,
        price: 1.78,
        isLiked: true
    )
    let viewModel = FavoriteNFTCellViewModel(model: model)
    FavoriteNFTCellView(viewModel: viewModel)
}
