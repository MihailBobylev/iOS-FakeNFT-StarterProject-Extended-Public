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
}

extension NFTCatalogCellModel {
    init(nft: Nft) {
        self.id = nft.id
        
        self.cover = nft.images.first?.absoluteString
        
        self.rating = {
            guard let rating = nft.rating
            else { return 0 }
            
            return min(max(rating, 0), 5)
        }()
        
        self.name = nft.name ?? "Без названия"
        
        self.price = {
            guard let price = nft.price else { return "0" }
            return NSDecimalNumber(decimal: price).stringValue
        }()
        
        self.isFavorite = false
        self.inBasket = false
    }
}
