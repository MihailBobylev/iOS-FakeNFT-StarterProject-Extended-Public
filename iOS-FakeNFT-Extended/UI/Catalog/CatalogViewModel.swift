//
//  CatalogViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 19.01.2026.
//

import Foundation

@MainActor
@Observable
final class CatalogViewModel {
    private let servicesAssembly: ServicesAssembly
    private let pageSize = 1
    private var currentPage = 0
    private var canLoadMore = true
    
    var nftCollections: [NFTCollectionDTO] = []
    var isLoading = false
    var isPageLoading = false
    var requestError: ErrorType?
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func loadNFTCollections() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = nil
        currentPage = 0
        canLoadMore = true
        nftCollections = []
        
        do {
            let pageCollections = try await servicesAssembly.nftService.fetchNFTCollections(
                page: currentPage,
                size: pageSize
            )
            
            nftCollections = pageCollections
            canLoadMore = pageCollections.count == pageSize
            currentPage += 1
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
    
    func loadNextPageIfNeeded(currentItem item: NFTCollectionDTO) async {
        guard canLoadMore,
              !isPageLoading,
              let last = nftCollections.last,
              last.id == item.id
        else { return }
        
        isPageLoading = true
        
        do {
            let pageCollections = try await servicesAssembly.nftService.fetchNFTCollections(
                page: currentPage,
                size: pageSize
            )
            
            nftCollections.append(contentsOf: pageCollections)
            canLoadMore = pageCollections.count == pageSize
            currentPage += 1
            isPageLoading = false
        } catch {
            isPageLoading = false
            requestError = .serverError
        }
    }
}
