//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

@Observable
final class MyNFTViewModel {
    let name: String
    let author: String
    let rating: Int
    let price: Double
    var isLiked: Bool
    
    init(model: MyNFTModel) {
        self.name = model.name
        self.author = model.author
        self.rating = model.rating
        self.price = model.price
        self.isLiked = model.isLiked
    }
    
    func toggleLike() async {
        isLiked.toggle()
    }
}
