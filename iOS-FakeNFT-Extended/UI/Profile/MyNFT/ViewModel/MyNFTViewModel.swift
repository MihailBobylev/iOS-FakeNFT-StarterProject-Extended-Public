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
    
    private var servicesAssembly: ServicesAssembly?
    var isLoading = false
    var requestError: ErrorType? = nil
    var nfts: [NftDTO] = []
    var ids: [String]
    var likedIds: [String]
    var sortType: SortType = .byPrice
    
    var sortedCells: [NftDTO] {
        switch sortType {
        case .byPrice:
            return nfts.sorted { $0.price ?? 0 < $1.price ?? 0 }
        case .byRating:
            return nfts.sorted { $0.rating ?? 0 > $1.rating ?? 0 }
        case .byName:
            return nfts.sorted { $0.name ?? "" < $1.name ?? "" }
        }
    }
    
    init(ids: [String], likedIds: [String]) {
        self.ids = ids
        self.likedIds = likedIds
    }
    
    func configure(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}

extension MyNFTViewModel {
    func loadNfts() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = .none
        
        nfts = []
        
        do {
            guard let servicesAssembly else { return }
            for id in ids {
                let nft = try await servicesAssembly.nftService.fetchNFT(with: id ?? "")
                self.nfts.append(nft)
            }
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
}
