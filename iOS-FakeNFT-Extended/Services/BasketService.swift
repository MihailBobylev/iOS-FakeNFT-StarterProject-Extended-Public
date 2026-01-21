//
//  BasketService.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

protocol BasketService {
    func loadItems() async -> [BasketItem]
    func add(nft: Nft) async
    func remove(id: String) async
    func clear() async
    func totalCount() async -> Int
    func totalPrice() async -> Double
}

@MainActor
final class BasketServiceImpl: BasketService {
    private let storage: BasketStorage

    init(storage: BasketStorage) {
        self.storage = storage
    }

    func loadItems() async -> [BasketItem] {
        await storage.getItems()
    }

    func add(nft: Nft) async {
        await storage.add(nft)
    }

    func remove(id: String) async {
        await storage.remove(id: id)
    }

    func clear() async {
        await storage.clear()
    }

    func totalCount() async -> Int {
        let items = await storage.getItems()
        return items.reduce(0) { $0 + $1.quantity }
    }

    func totalPrice() async -> Double {
        let items = await storage.getItems()
        return items.reduce(0) { $0 + ($1.nft.price * Double($1.quantity)) }
    }
}

