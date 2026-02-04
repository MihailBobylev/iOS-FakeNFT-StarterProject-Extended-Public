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

struct PaymentRequest: NetworkRequest {
    let currencyId: String
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currencyId)")
    }
    
    var httpMethod: HttpMethod { .get }
}

struct PaymentResponse: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}

