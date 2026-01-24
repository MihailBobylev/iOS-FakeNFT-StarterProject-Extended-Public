//
//  CatalogDetailsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 22.01.2026.
//

import Foundation

@MainActor
@Observable
final class CatalogDetailsViewModel {
    private var servicesAssembly: ServicesAssembly?
    let nftCollection: NFTCollectionDTO
    
    init(nftCollection: NFTCollectionDTO) {
        self.nftCollection = nftCollection
    }
    
    func setup(servicesAssembly: ServicesAssembly) {
        guard self.servicesAssembly == nil else { return }
        self.servicesAssembly = servicesAssembly
    }
}
