//
//  NFTCatalogCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 24.01.2026.
//

import SwiftUI

struct NFTCatalogCell: View {
    private enum Constants {
        static let currency = "ETH"
    }
    
    let model: NFTCatalogCellModel
    let onFavoriteTap: (_ id: String) -> Void
    let onBasketTap: (_ id: String) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                if let url = URL(string: model.cover ?? "") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipped()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Image(.ilNftCardDefault)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Button {
                    onFavoriteTap(model.id)
                } label: {
                    Image(model.isFavorite ? .icFavorites : .icUnfavorites)
                        .renderingMode(.original)
                }
            }
            
            NFTRatingView(rating: model.rating)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.name)
                        .font(.title3Bold)
                        .foregroundStyle(.ypBlack)
                        .lineLimit(1)
                    
                    Text("\(model.price) \(Constants.currency)")
                        .font(.bodyMedium)
                        .foregroundStyle(.ypBlack)
                }
                Spacer()
                Button {
                    onBasketTap(model.id)
                } label: {
                    Image(model.inBasket ? .icBasketIn : .icBasketOut)
                        .renderingMode(.original)
                }
            }
        }
    }
}

#Preview {
    NFTCatalogCell(
        model: NFTCatalogCellModel(
            id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            rating: 3,
            name: "recteque fabellas",
            price: "39.37",
            isFavorite: true,
            inBasket: true
        ),
        onFavoriteTap: { id in },
        onBasketTap: { id in }
    )
}
