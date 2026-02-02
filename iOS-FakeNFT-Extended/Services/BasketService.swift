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
    private let orderService: OrderService
    private let nftService: NftService

    init(storage: BasketStorage, orderService: OrderService, nftService: NftService) {
        self.storage = storage
        self.orderService = orderService
        self.nftService = nftService
    }

    func loadItems() async -> [BasketItem] {
        do {
            let order = try await orderService.loadOrder()
            var items: [BasketItem] = []
            let grouped = Dictionary(grouping: order.nfts) { $0 }
            for (nftId, ids) in grouped {
                guard let nft = try? await nftService.loadNft(id: nftId) else { continue }
                items.append(BasketItem(id: nft.id, nft: nft, quantity: ids.count))
            }
            return items
        } catch {
            return []
        }
    }

    func add(nft: Nft) async {
        do {
            let order = try await orderService.loadOrder()
            var nfts = order.nfts
            nfts.append(nft.id)
            _ = try await orderService.updateOrder(nfts: nfts)
        } catch {
            // при ошибке сети операция не выполняется
        }
    }

    func remove(id: String) async {
        do {
            let order = try await orderService.loadOrder()
            var nfts = order.nfts
            if let index = nfts.firstIndex(of: id) {
                nfts.remove(at: index)
                _ = try await orderService.updateOrder(nfts: nfts)
            }
        } catch {
          
        }
    }

    func clear() async {
        do {
            _ = try await orderService.updateOrder(nfts: [])
        } catch {
           
        }
    }

    func totalCount() async -> Int {
        let items = await loadItems()
        return items.reduce(0) { $0 + $1.quantity }
    }

    func totalPrice() async -> Double {
        let items = await loadItems()
        return items.reduce(0) { $0 + ($1.nft.price * Double($1.quantity)) }
    }
}

