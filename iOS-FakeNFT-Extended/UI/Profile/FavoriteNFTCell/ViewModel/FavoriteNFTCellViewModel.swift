//
//  FavoriteNFTCellViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

@Observable
final class FavoriteNFTCellViewModel: Identifiable {
    var model: NftDTO
    private var servicesAssembly: ServicesAssembly
    private var mainViewModel: FavoriteNFTViewModel
    var isLoading = false
    var requestError: ErrorType? = nil
    
    var id: String
    var ids: [String]
    
    init(
        model: NftDTO,
        with ids: [String],
        mainViewModel: FavoriteNFTViewModel,
        servicesAssembly: ServicesAssembly
    ) {
        self.model = model
        self.id = model.id
        self.ids = ids
        self.mainViewModel = mainViewModel
        self.servicesAssembly = servicesAssembly
    }
    
    func toggleLike() async {
        if ids.contains(id) {
            ids.removeAll {
                $0 == id
            }
        } else {
            ids.append(id)
        }
        
        if (ids.isEmpty) {
            ids = ["null"]
        }
        
        await updateLikeNFT()
        
        if (ids.isEmpty) {
            mainViewModel.nfts.removeAll()
            mainViewModel.ids.removeAll()
        } else {
            mainViewModel.nfts.removeAll {
                $0.id == id
            }
            mainViewModel.ids.removeAll {
                $0 == id
            }
        }
    }
}

extension FavoriteNFTCellViewModel {
    func updateLikeNFT() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = .none
        
        do {
            let _ = try await servicesAssembly.nftService.updateLikedNFT(with: ids)
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
}
