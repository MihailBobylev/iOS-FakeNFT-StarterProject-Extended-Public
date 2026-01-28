//
//  FavoriteNFTCellIconView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct FavoriteNFTCellIconView: View {
    @Binding var viewModel: FavoriteNFTCellViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(.nft)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                Task {
                    await viewModel.toggleLike()
                }
            } label: {
                Image(viewModel.model.isLiked ? .icFavorites : .icUnfavorites)
                    .foregroundStyle(viewModel.model.isLiked ? .ypRed : .ypWhite)
                    .padding(-7)
            }

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
    FavoriteNFTCellIconView(viewModel: $viewModel)
}
