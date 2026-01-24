//
//  FavoriteNFTCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct FavoriteNFTCellView: View {
    @State var viewModel: FavoriteNFTViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            FavoriteNFTIconView(viewModel: $viewModel)
            Spacer()
            FavoriteNFTDescriptionView(viewModel: $viewModel)
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
    FavoriteNFTCellView(viewModel: viewModel)
}
