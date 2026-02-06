//
//  CurrencyService.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import Foundation

protocol CurrencyService {
    func loadCurrencies() async throws -> [Currency]
}

@MainActor
final class CurrencyServiceImpl: CurrencyService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func loadCurrencies() async throws -> [Currency] {
        let request = CurrenciesRequest()
        let dtos: [CurrencyDTO] = try await networkClient.send(request: request)
        return dtos.map { $0.toDomain() }
    }
}
