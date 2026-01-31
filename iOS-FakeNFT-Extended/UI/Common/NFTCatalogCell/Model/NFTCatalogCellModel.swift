//
//  NFTCatalogCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 24.01.2026.
//

import Foundation

struct NFTCatalogCellModel: Identifiable {
    enum Constants {
        static let noName = "Без названия"
    }
    
    let id: String
    let cover: String?
    let rating: Int
    let name: String
    let price: String
    var isFavorite: Bool
    var inBasket: Bool
}

extension NFTCatalogCellModel {
    init(
        nft: Nft,
        isFavorite: Bool,
        inBasket: Bool
    ) {
        self.id = nft.id
        
        self.cover = nft.images.first?.absoluteString
        
        self.rating = {
            guard let rating = nft.rating
            else { return 0 }
            
            return min(max(rating, 0), 5)
        }()
        
        self.name = nft.name ?? Constants.noName
        
        self.price = {
            guard let price = nft.price else { return "" }
            return NSDecimalNumber(decimal: price).stringValue
        }()
        
        self.isFavorite = isFavorite
        self.inBasket = inBasket
    }
}
