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
    
    init(model: MyNFTCellModel) {
        self.model = model
        self.id = model.id
    }
    
    func toggleLike() async {
        model.isLiked.toggle()
    }
}
