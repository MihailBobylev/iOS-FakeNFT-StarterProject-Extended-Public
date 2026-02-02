//
//  FavoriteNFTCellIconView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct FavoriteNFTCellIconView: View {
    var viewModel: FavoriteNFTCellViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            image(url: URL(string: viewModel.model.images[0] ?? ""))
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Button {
                Task {
                    await viewModel.toggleLike()
                }
            } label: {
                Image(.icFavorites)
                    .foregroundStyle(.ypRed)
                    .padding(-7)
            }

        }
    }
    
    @ViewBuilder
    private func image(url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                placeholder
            case .success(let image):
                ZStack {
                    ProgressView()
                        .frame(width: 70, height: 70)
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            case .failure:
                ZStack {
                    placeholder
                }
            @unknown default:
                placeholder
            }
        }
    }
    private var placeholder: some View {
        Color.gray.opacity(0.2)
    }
}
