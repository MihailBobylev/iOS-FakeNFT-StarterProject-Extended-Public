//
//  OrderService.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import Foundation

protocol OrderService {
    func loadOrder() async throws -> OrderDTO
    func updateOrder(nfts: [String]) async throws -> OrderDTO
    /// POST orders/1 с nfts заказа бэкенд добавляет их в профиль и очищает заказ.
    func executeOrder(nfts: [String]) async throws -> OrderDTO
}

@MainActor
final class OrderServiceImpl: OrderService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadOrder() async throws -> OrderDTO {
        let request = OrderRequest()
        return try await networkClient.send(request: request)
    }

    func updateOrder(nfts: [String]) async throws -> OrderDTO {
        let request = OrderUpdateRequest(nfts: nfts)
        return try await networkClient.send(request: request)
    }

    func executeOrder(nfts: [String]) async throws -> OrderDTO {
        let request = OrderExecuteRequest(nfts: nfts)
        return try await networkClient.send(request: request)
    }
}
