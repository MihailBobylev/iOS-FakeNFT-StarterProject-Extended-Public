//
//  BasketService.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

protocol BasketService {
    func loadItems() async throws -> [BasketItem]
    func add(nft: Nft) async throws
    func remove(id: String) async throws
    func clear() async throws
    func totalCount() async throws -> Int
    func totalPrice() async throws -> Double
}

@MainActor
final class BasketServiceImpl: BasketService {
    private let storage: BasketStorage
    private let orderService: OrderService
    private let nftService: NftService

    init(storage: BasketStorage, orderService: OrderService, nftService: NftService) {
        self.storage = storage
        self.orderService = orderService
        self.nftService = nftService
    }

    func loadItems() async throws -> [BasketItem] {
        let order = try await orderService.loadOrder()
        var items: [BasketItem] = []
        let grouped = Dictionary(grouping: order.nfts) { $0 }
        for (nftId, ids) in grouped {
            guard let nft = try? await nftService.loadNft(id: nftId) else { continue }
            items.append(BasketItem(id: nft.id, nft: nft, quantity: ids.count))
        }
        return items
    }

    func add(nft: Nft) async throws {
        let order = try await orderService.loadOrder()
        var nfts = order.nfts
        nfts.append(nft.id)
        _ = try await orderService.updateOrder(nfts: nfts)
    }

    func remove(id: String) async throws {
        let order = try await orderService.loadOrder()
        var nfts = order.nfts
        if let index = nfts.firstIndex(of: id) {
            nfts.remove(at: index)
            _ = try await orderService.updateOrder(nfts: nfts)
        }
    }

    func clear() async throws {
        _ = try await orderService.updateOrder(nfts: [])
    }

    func totalCount() async throws -> Int {
        let items = try await loadItems()
        return items.reduce(0) { $0 + $1.quantity }
    }

    func totalPrice() async throws -> Double {
        let items = try await loadItems()
        return items.reduce(0) { $0 + ($1.nft.price * Double($1.quantity)) }
    }
}

