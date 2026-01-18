//
//  FavoriteNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

@Observable
final class FavoriteNFTViewModel {
    let name: String
    let rating: Int
    let price: Double
    var isLiked: Bool
    
    init(model: FavoriteNFTModel) {
        self.name = model.name
        self.rating = model.rating
        self.price = model.price
        self.isLiked = model.isLiked
    }
    
    func toggleLike() async {
        isLiked.toggle()
    }
}
