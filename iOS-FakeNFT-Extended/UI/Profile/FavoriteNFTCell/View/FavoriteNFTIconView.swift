//
//  MyNFTIconView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct FavoriteNFTIconView: View {
    @Binding var viewModel: FavoriteNFTViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("nft")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                Task {
                    await viewModel.toggleLike()
                }
            } label: {
                Image(viewModel.isLiked ? "ic_favorites" : "ic_unfavorites")
                    .foregroundStyle(viewModel.isLiked ? .ypRed : .ypWhite)
                    .padding(-7)
            }

        }
    }
}

#Preview {
    @Previewable @State var viewModel = FavoriteNFTViewModel(
        model: FavoriteNFTModel(
            name: "Archie",
            rating: 1,
            price: 1.78,
            isLiked: true
        )
    )
    FavoriteNFTIconView(viewModel: $viewModel)
}
