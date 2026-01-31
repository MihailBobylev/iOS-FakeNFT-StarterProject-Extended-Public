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
    
    var nftCollections: [NFTCollectionModel] = []
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
    
    func loadFavoriteNFTs() async {
        guard let servicesAssembly, !isLoading else { return }
        
        isLoading = true
        requestError = nil
        do {
            try await servicesAssembly.nftService.loadFavoriteNFTs()
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
            requestError = .serverError
        }
    }
    
    func loadNFTCollections() async {
        currentSort = nil
        await reload()
    }
    
    func applySort(_ sort: NFTCollectionSort) async {
        guard currentSort != sort else { return }
        currentSort = sort
        await reload()
    }
    
    func loadNextPageIfNeeded(currentItem item: NFTCollectionModel) async {
        guard canLoadMore,
              !isPageLoading,
              let last = nftCollections.last,
              last.id == item.id
        else { return }
        
        isPageLoading = true
        
        do {
            let collectionsModel = try await fetchCollections()
            var updatedCollections = nftCollections
            updatedCollections.append(contentsOf: collectionsModel)
            
            nftCollections = updatedCollections
            canLoadMore = collectionsModel.count == pageSize
            currentPage += 1
            isPageLoading = false
        } catch {
            isPageLoading = false
            requestError = .serverError
        }
    }
    
    private func reload() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = nil
        currentPage = 0
        canLoadMore = true
        
        do {
            let collectionsModel = try await fetchCollections()
            nftCollections = collectionsModel
            canLoadMore = collectionsModel.count == pageSize
            currentPage += 1
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
    
    private func fetchCollections() async throws -> [NFTCollectionModel] {
        guard let servicesAssembly else { return [] }
        
        let pageCollections = try await servicesAssembly.nftService.fetchNFTCollections(
            page: currentPage,
            size: pageSize,
            sortBy: currentSort
        )
        
        let collectionsModel = pageCollections.map {
            NFTCollectionModel(collectionDTO: $0)
        }
        return collectionsModel
    }
}
