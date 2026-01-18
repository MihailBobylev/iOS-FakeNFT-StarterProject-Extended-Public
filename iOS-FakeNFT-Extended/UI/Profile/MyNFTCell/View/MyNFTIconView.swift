//
//  MyNFTIconView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTIconView: View {
    @Binding var viewModel: MyNFTViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("nft")
                .resizable()
                .scaledToFill()
                .frame(width: 108, height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                Task {
                    await viewModel.toggleLike()
                }
            } label: {
                Image(viewModel.isLiked ? "ic_favorites" : "ic_unfavorites")
                    .foregroundStyle(viewModel.isLiked ? .ypRed : .ypWhite)
            }

        }
    }
}

#Preview {
    @Previewable @State var viewModel = MyNFTViewModel(
        model: MyNFTModel(
            name: "Archie",
            author: "John Doe",
            rating: 1,
            price: 1.78,
            isLiked: true
        )
    )
    MyNFTIconView(viewModel: $viewModel)
}
