//
//  PaymentService.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

enum PaymentError: Error {
    case failed
    case networkError(Error)
}

protocol PaymentService {
    func pay(currencyId: String) async throws -> PaymentResponse
}

final class PaymentServiceImpl: PaymentService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func pay(currencyId: String) async throws -> PaymentResponse {
        let request = PaymentRequest(currencyId: currencyId)
        let response: PaymentResponse = try await networkClient.send(request: request)
        
        guard response.success else {
            throw PaymentError.failed
        }
        
        return response
    }
}

// MARK: - Mock для тестирования без сети
final class MockPaymentService: PaymentService {
    var shouldSucceed = true
    var delay: UInt64 = 500_000_000 // 0.5 секунды
    
    func pay(currencyId: String) async throws -> PaymentResponse {
        try await Task.sleep(nanoseconds: delay)
        
        if shouldSucceed {
            return PaymentResponse(
                success: true,
                orderId: "mock-order-1",
                id: currencyId
            )
        } else {
            throw PaymentError.failed
        }
    }
}

