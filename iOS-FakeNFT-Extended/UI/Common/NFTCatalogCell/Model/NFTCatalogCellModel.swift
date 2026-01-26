//
//  NFTCatalogCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 24.01.2026.
//

import Foundation

struct NFTCatalogCellModel: Identifiable {
    let id: String
    let cover: String?
    let rating: Int
    let name: String
    let price: String
    let isFavorite: Bool
    let inBasket: Bool
    
    static let mockData: [NFTCatalogCellModel] = [
        NFTCatalogCellModel(
            id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c1",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            rating: 1,
            name: "recteque fabellas",
            price: "39.37",
            isFavorite: true,
            inBasket: true
        ),
        NFTCatalogCellModel(
            id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c2",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            rating: 2,
            name: "recteque fabellas",
            price: "39.37",
            isFavorite: true,
            inBasket: false
        ),
        NFTCatalogCellModel(
            id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c3",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            rating: 3,
            name: "recteque fabellas",
            price: "39.37",
            isFavorite: false,
            inBasket: true
        ),
        NFTCatalogCellModel(
            id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c4",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            rating: 4,
            name: "recteque fabellas",
            price: "39.37",
            isFavorite: false,
            inBasket: false
        ),
        NFTCatalogCellModel(
            id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c5",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Ellsa/1.png",
            rating: 5,
            name: "recteque fabellas",
            price: "39.37",
            isFavorite: true,
            inBasket: true
        )
    ]
}
