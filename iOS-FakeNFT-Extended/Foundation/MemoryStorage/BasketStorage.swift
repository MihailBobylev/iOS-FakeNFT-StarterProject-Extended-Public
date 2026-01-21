//
//  BasketStorage.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

protocol BasketStorage: AnyObject {
    func getItems() async -> [BasketItem]
    func add(_ nft: Nft) async
    func remove(id: String) async
    func clear() async
}

actor BasketStorageImpl: BasketStorage {
    private var items: [BasketItem] = []

    func getItems() async -> [BasketItem] {
        items
    }

    func add(_ nft: Nft) async {
        if let index = items.firstIndex(where: { $0.id == nft.id }) {
            let current = items[index]
            let updated = BasketItem(
                id: current.id,
                nft: current.nft,
                quantity: current.quantity + 1
            )
            items[index] = updated
        } else {
            let newItem = BasketItem(id: nft.id, nft: nft, quantity: 1)
            items.append(newItem)
        }
    }

    func remove(id: String) async {
        items.removeAll { $0.id == id }
    }

    func clear() async {
        items.removeAll()
    }
    
    func addTestData(_ nfts: [Nft]) async {
        for nft in nfts {
            await add(nft)
        }
    }
}

