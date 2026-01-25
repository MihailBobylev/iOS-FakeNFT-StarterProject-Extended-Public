//
//  FavoriteNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

@Observable
final class FavoriteNFTViewModel {
    private var model: FavoriteNFTModel
    var cellViewModels: [FavoriteNFTCellViewModel] {
        model.cells.map {
            FavoriteNFTCellViewModel(model: $0)
        }
    }
    
    init(items: [FavoriteNFTCellModel] = []) {
        self.model = FavoriteNFTModel(cells: items)
        self.model = mockFavoriteNFTModel()
    }
    
}

extension FavoriteNFTViewModel {
    func mockFavoriteNFTModel() -> FavoriteNFTModel {
        let favoriteNFTCellModel1 = FavoriteNFTCellModel(
            name: "B.Name",
            rating: 1,
            price: 1.44,
            isLiked: true
        )
        let favoriteNFTCellModel2 = FavoriteNFTCellModel(
            name: "A.Name",
            rating: 3,
            price: 2.44,
            isLiked: true
        )
        let favoriteNFTCellModel3 = FavoriteNFTCellModel(
            name: "C.Name",
            rating: 5,
            price: 2.04,
            isLiked: true
        )
        let favoriteNFTCellModel4 = FavoriteNFTCellModel(
            name: "D.Name",
            rating: 4,
            price: 1.77,
            isLiked: true
        )
        let favoriteNFTCellModel5 = FavoriteNFTCellModel(
            name: "E.Name",
            rating: 3,
            price: 2.44,
            isLiked: true
        )
        let favoriteNFTCellModel6 = FavoriteNFTCellModel(
            name: "F.Name",
            rating: 2,
            price: 1.65,
            isLiked: true
        )
        return FavoriteNFTModel(cells: [
            favoriteNFTCellModel1,
            favoriteNFTCellModel2,
            favoriteNFTCellModel3,
            favoriteNFTCellModel4,
            favoriteNFTCellModel5,
            favoriteNFTCellModel6
        ])
    }
}
