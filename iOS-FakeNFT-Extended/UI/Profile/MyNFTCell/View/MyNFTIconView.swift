//
//  MyNFTIconView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTIconView: View {
    @Binding var viewModel: MyNFTCellViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(.nft)
                .resizable()
                .scaledToFill()
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                Task {
                    await viewModel.toggleLike()
                }
            } label: {
                Image(viewModel.model.isLiked ? .icFavorites : .icUnfavorites)
                    .foregroundStyle(viewModel.model.isLiked ? .ypRed : .ypWhite)
            }

        }
    }
}

#Preview {
    @Previewable @State var viewModel = MyNFTCellViewModel(
        model: MyNFTCellModel(
            name: "Archie",
            author: "John Doe",
            rating: 1,
            price: 1.78,
            isLiked: true
        )
    )
    MyNFTIconView(viewModel: $viewModel)
}
