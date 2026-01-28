//
//  FavoriteNFTCellModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

struct FavoriteNFTCellModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let rating: Int
    let price: Double
    var isLiked: Bool
}
