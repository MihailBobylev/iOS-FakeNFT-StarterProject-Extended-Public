//
//  BasketService.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

protocol BasketService {
    func loadOrder() async throws -> OrderDTO
    func loadItems() async throws -> [BasketItem]
    func remove(id: String) async throws
    func clear() async throws
}

@MainActor
final class BasketServiceImpl: BasketService {
    private let orderService: OrderService
    private let nftService: NftServiceProtocol
    
    init(orderService: OrderService, nftService: NftServiceProtocol) {
        self.orderService = orderService
        self.nftService = nftService
    }

    func loadOrder() async throws -> OrderDTO {
        try await orderService.loadOrder()
    }

    func loadItems() async throws -> [BasketItem] {
        let order = try await orderService.loadOrder()
        var items: [BasketItem] = []
        let grouped = Dictionary(grouping: order.nfts) { $0 }
        for (nftId, ids) in grouped {
            let nftModel = try await nftService.loadNft(id: nftId)
            items.append(
                BasketItem(
                    id: nftModel.id,
                    nft: nftModel,
                    quantity: ids.count
                )
            )
        }
        return items
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
        _ = try await orderService.executeOrder()
    }
}

