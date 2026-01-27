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
    
    init(model: FavoriteNFTCellModel) {
        self.model = model
        self.id = model.id
    }
    
    func toggleLike() async {
        model.isLiked.toggle()
    }
}
