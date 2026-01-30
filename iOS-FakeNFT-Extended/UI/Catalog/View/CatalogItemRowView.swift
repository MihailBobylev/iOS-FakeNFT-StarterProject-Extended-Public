//
//  CatalogItemView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 17.01.2026.
//

import SwiftUI

struct CatalogItemRowView: View {
    let model: NFTCollectionModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let url = URL(string: model.cover ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(minHeight: 140)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text("\(model.name ?? "") (\(model.nfts.count))")
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    CatalogItemRowView(
        model: NFTCollectionModel(
            id: "asdasd",
            name: "Brown",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png",
            nfts: ["1", "2", "3"],
            description: "",
            author: ""
        )
    )
    .frame(maxHeight: 162)
}
