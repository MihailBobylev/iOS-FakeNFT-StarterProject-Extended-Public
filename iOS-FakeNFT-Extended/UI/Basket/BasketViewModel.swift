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
    var isEmpty: Bool {
        items.isEmpty
    }
    
    private let basketService: BasketService
    
    init(basketService: BasketService) {
        self.basketService = basketService
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }
        
        items = await basketService.loadItems()
    }
}
