//
//  CatalogViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 19.01.2026.
//

import Foundation

enum NFTCollectionSort: String {
    case name
    case nfts
}

@MainActor
@Observable
final class CatalogViewModel {
    
    private var servicesAssembly: ServicesAssembly?
    
    private let pageSize = 10
    private var currentPage = 0
    private var canLoadMore = true
    
    var nftCollections: [NFTCollectionDTO] = []
    var isLoading = false
    var isPageLoading = false
    var canChangeSort: Bool {
        !isLoading && !isPageLoading
    }
    var requestError: ErrorType?
    var currentSort: NFTCollectionSort?
    
    func setup(servicesAssembly: ServicesAssembly) {
        guard self.servicesAssembly == nil else { return }
        self.servicesAssembly = servicesAssembly
    }
    
    func loadNFTCollections() async {
        await reload()
    }
    
    func applySort(_ sort: NFTCollectionSort) async {
        guard currentSort != sort else { return }
        currentSort = sort
        await reload()
    }
    
    func loadNextPageIfNeeded(currentItem item: NFTCollectionDTO) async {
        guard let servicesAssembly,
              canLoadMore,
              !isPageLoading,
              let last = nftCollections.last,
              last.id == item.id
        else { return }
        
        isPageLoading = true
        
        do {
            let pageCollections = try await servicesAssembly.nftService.fetchNFTCollections(
                page: currentPage,
                size: pageSize,
                sortBy: currentSort
            )
            
            var updatedCollections = nftCollections
            updatedCollections.append(contentsOf: pageCollections)
            
            nftCollections = updatedCollections
            canLoadMore = pageCollections.count == pageSize
            currentPage += 1
            isPageLoading = false
        } catch {
            isPageLoading = false
            requestError = .serverError
        }
    }
    
    private func reload() async {
        guard let servicesAssembly, !isLoading else { return }
        
        isLoading = true
        requestError = nil
        currentPage = 0
        canLoadMore = true
        
        do {
            let pageCollections = try await servicesAssembly.nftService.fetchNFTCollections(
                page: currentPage,
                size: pageSize,
                sortBy: currentSort
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
}
