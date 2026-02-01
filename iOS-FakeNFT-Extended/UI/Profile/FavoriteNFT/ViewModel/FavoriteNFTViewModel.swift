//
//  FavoriteNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

@Observable
final class FavoriteNFTViewModel {
    private var servicesAssembly: ServicesAssembly?
    var isLoading = false
    var requestError: ErrorType? = nil
    
    var nfts: [NftDTO] = []
    
    var ids: [String?]
    
    init(ids: [String?]) {
        self.ids = ids
    }
    
    func configure(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
}

extension FavoriteNFTViewModel {
    func loadNfts() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = .none
        
        nfts = []
        
        do {
            guard let servicesAssembly else { return }
            for id in ids {
                let nft = try await servicesAssembly.nftService.fetchLikedNFT(with: id ?? "")
                self.nfts.append(nft)
            }
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
}
