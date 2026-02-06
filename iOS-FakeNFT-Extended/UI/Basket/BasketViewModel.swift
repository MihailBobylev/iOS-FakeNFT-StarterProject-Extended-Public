//
//  BasketViewModel.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

struct BasketItem: Identifiable, Sendable {
    let id: String
    let nft: NFTCatalogCellModel
    let quantity: Int
}

enum BasketSortOption: String, CaseIterable, Sendable {
    case name
    case price
    case rating
}

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
    private var currentSortOption: BasketSortOption = .name
    
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
            items.sort(by: { (lhs: BasketItem, rhs: BasketItem) -> Bool in
                lhs.nft.name.localizedCaseInsensitiveCompare(rhs.nft.name) == .orderedAscending
            })
        case .price:
            items.sort(by: { (lhs: BasketItem, rhs: BasketItem) -> Bool in
                let leftPrice = Decimal(string: lhs.nft.price) ?? .zero
                let rightPrice = Decimal(string: rhs.nft.price) ?? .zero
                return leftPrice < rightPrice
            })
        case .rating:
            items.sort(by: { (lhs: BasketItem, rhs: BasketItem) -> Bool in
                lhs.nft.rating > rhs.nft.rating
            })
        }
    }
    
    func setSortOption(_ option: BasketSortOption) {
        currentSortOption = option
    }
    
    var totalCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Decimal {
        items.reduce(Decimal.zero) { partial, item in
            guard let price = Decimal(string: item.nft.price) else { return partial }
            return partial + price * Decimal(item.quantity)
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
