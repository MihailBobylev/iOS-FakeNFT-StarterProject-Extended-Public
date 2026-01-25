//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 24.01.2026.
//

import Foundation

@Observable
final class MyNFTViewModel {
    enum SortType {
        case byPrice
        case byRating
        case byName
    }
    
    private var model: MyNFTModel
    var sortType: SortType = .byPrice
    
    var cellViewModels: [MyNFTCellViewModel] {
        sortedCells.map {
            MyNFTCellViewModel(model: $0)
        }
    }
    
    private var sortedCells: [MyNFTCellModel] {
        switch sortType {
        case .byPrice:
            return model.cells.sorted { $0.price < $1.price }
        case .byRating:
            return model.cells.sorted { $0.rating > $1.rating }
        case .byName:
            return model.cells.sorted { $0.name < $1.name }
        }
    }
    
    init(items: [MyNFTCellModel] = []) {
        self.model = MyNFTModel(cells: items)
        self.model = mockMyNFTModel()
    }
}

extension MyNFTViewModel {
    func mockMyNFTModel() -> MyNFTModel {
        let myNFTCellModel1 = MyNFTCellModel(
            name: "B.Name",
            author: "Author",
            rating: 1,
            price: 1.44,
            isLiked: true
        )
        let myNFTCellModel2 = MyNFTCellModel(
            name: "A.Name",
            author: "Author",
            rating: 3,
            price: 2.44,
            isLiked: true
        )
        let myNFTCellModel3 = MyNFTCellModel(
            name: "C.Name",
            author: "Author",
            rating: 5,
            price: 2.04,
            isLiked: true
        )
        let myNFTCellModel4 = MyNFTCellModel(
            name: "D.Name",
            author: "Author",
            rating: 4,
            price: 1.77,
            isLiked: true
        )
        let myNFTCellModel5 = MyNFTCellModel(
            name: "E.Name",
            author: "Author",
            rating: 3,
            price: 2.44,
            isLiked: true
        )
        let myNFTCellModel6 = MyNFTCellModel(
            name: "F.Name",
            author: "Author",
            rating: 2,
            price: 1.65,
            isLiked: true
        )
        return MyNFTModel(cells: [
            myNFTCellModel1,
            myNFTCellModel2,
            myNFTCellModel3,
            myNFTCellModel4,
            myNFTCellModel5,
            myNFTCellModel6
        ])
    }
}
