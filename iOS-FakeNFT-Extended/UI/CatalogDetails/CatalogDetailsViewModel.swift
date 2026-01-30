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
    let nftCollection: NFTCollectionModel
    
    var nfts: [NFTCatalogCellModel] = []
    var isLoading = false
    var requestError: ErrorType?
    
    init(nftCollection: NFTCollectionModel) {
        self.nftCollection = nftCollection
    }
    
    func setup(servicesAssembly: ServicesAssembly) {
        guard self.servicesAssembly == nil else { return }
        self.servicesAssembly = servicesAssembly
    }
    
    func loadNFTs() async {
        guard let servicesAssembly, !isLoading else { return }
        
        isLoading = true
        requestError = nil
        
        do {
            let nfts = try await servicesAssembly.nftService.loadNfts(ids: nftCollection.nfts)
            self.nfts = nfts
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
    
    func toggleFavorite(with id: String) async {
        guard let servicesAssembly,
              await servicesAssembly.nftService.changeFavoriteNFT(id: id),
              let index = nfts.firstIndex(where: { $0.id == id }) else {
            return
        }
        nfts[index].isFavorite.toggle()
    }
    
    func toggleBasket(with id: String) async {
        guard let servicesAssembly,
              await servicesAssembly.nftService.changeBasketNFT(id: id),
              let index = nfts.firstIndex(where: { $0.id == id }) else {
            return
        }
        nfts[index].inBasket.toggle()
    }
}
