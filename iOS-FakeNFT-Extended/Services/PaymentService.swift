//
//  PaymentService.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

enum PaymentError: Error {
    case failed
}

protocol PaymentService {
    func pay(items: [BasketItem], currency: Currency) async throws
}

@MainActor
final class PaymentServiceImpl: PaymentService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func pay(items: [BasketItem], currency: Currency) async throws {
        // TODO: заменить на реальный запрос оплаты, пока имитируем успешный результат
        _ = items
        _ = currency
    }
}

