//
//  BasketViewModel.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

@Observable
@MainActor
final class BasketViewModel {
    
    var items: [BasketItem] = []
    var isLoading = false
    var loadError: Error?
    var isEmpty: Bool {
        items.isEmpty && !isLoading
    }
    
    private let basketService: BasketService
    private let sortOptionKey = "BasketSortOption"
    
    var currentSortOption: BasketSortOption {
        get {
            if let rawValue = UserDefaults.standard.string(forKey: sortOptionKey),
               let option = BasketSortOption(rawValue: rawValue) {
                return option
            }
            return .name // По умолчанию для корзины по названию
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: sortOptionKey)
            applySort()
        }
    }
    
    init(basketService: BasketService) {
        self.basketService = basketService
    }
    
    func loadItems() async {
        isLoading = true
        loadError = nil
        defer { isLoading = false }
        
        do {
            items = try await basketService.loadItems()
            applySort()
        } catch {
            loadError = error
            items = []
        }
    }
    
    func clearLoadError() {
        loadError = nil
    }
    
    private func applySort() {
        switch currentSortOption {
        case .name:
            items.sort { $0.nft.name.localizedCaseInsensitiveCompare($1.nft.name) == .orderedAscending }
        case .price:
            items.sort { $0.nft.price < $1.nft.price }
        case .rating:
            items.sort { $0.nft.rating > $1.nft.rating }
        }
    }
    
    func setSortOption(_ option: BasketSortOption) {
        currentSortOption = option
    }
    
    var totalCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.nft.price * Double($1.quantity)) }
    }
    
    func addTestData() async {
        do {
            for nft in Nft.mocks {
                try await basketService.add(nft: nft)
            }
            await loadItems()
        } catch {
            loadError = error
        }
    }
    
    func removeItem(id: String) async {
        do {
            try await basketService.remove(id: id)
            await loadItems()
        } catch {
            loadError = error
        }
    }
}
