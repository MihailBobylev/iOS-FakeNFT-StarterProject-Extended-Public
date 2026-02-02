//
//  MyNFTViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import Foundation

@Observable
final class MyNFTCellViewModel: Identifiable {
    var model: NftDTO
    private var servicesAssembly: ServicesAssembly
    private var mainViewModel: MyNFTViewModel
    var isLoading = false
    var requestError: ErrorType? = nil
    
    var id: String
    var ids: [String]
    var likedIds: [String]
    
    init(
        model: NftDTO,
        ids: [String],
        likedIds: [String],
        mainViewModel: MyNFTViewModel,
        servicesAssembly: ServicesAssembly
    ) {
        self.model = model
        self.id = model.id
        self.ids = ids
        self.likedIds = likedIds
        self.mainViewModel = mainViewModel
        self.servicesAssembly = servicesAssembly
    }
    
    var isLiked: Bool {
        likedIds.contains(id)
    }
    
    func toggleLike() async {
        if isLiked {
            likedIds.removeAll {
                $0 == id
            }
            if (likedIds.isEmpty) {
                mainViewModel.likedIds.removeAll()
            } else {
                mainViewModel.likedIds.removeAll {
                    $0 == id
                }
            }
        } else {
            likedIds.append(id)
            mainViewModel.likedIds.append(id)
        }
        if (likedIds.isEmpty) {
            likedIds = ["null"]
        }
        await updateLikeNFT()
    }
}

extension MyNFTCellViewModel {
    func updateLikeNFT() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = .none
        
        do {
            let _ = try await servicesAssembly.nftService.updateLikedNFT(with: likedIds)
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
}
