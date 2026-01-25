//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

@Observable
final class MyNFTCellViewModel: Identifiable {
    let id: UUID
    var model: MyNFTCellModel
//    let name: String
//    let author: String
//    let rating: Int
//    let price: Double
//    var isLiked: Bool
    
    init(model: MyNFTCellModel) {
//        self.name = model.name
//        self.author = model.author
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
