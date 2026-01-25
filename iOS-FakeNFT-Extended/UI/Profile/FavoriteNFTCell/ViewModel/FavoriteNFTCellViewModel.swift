//
//  FavoriteNFTCellViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

@Observable
final class FavoriteNFTCellViewModel: Identifiable {
    let id: UUID
    var model: FavoriteNFTCellModel
//    let name: String
//    let rating: Int
//    let price: Double
//    var isLiked: Bool
    
    init(model: FavoriteNFTCellModel) {
//        self.name = model.name
//        self.rating = model.rating
//        self.price = model.price
//        self.isLiked = model.isLiked
        self.model = model
        self.id = model.id
    }
    
    func toggleLike() async {
        model.isLiked.toggle()
    }
}
