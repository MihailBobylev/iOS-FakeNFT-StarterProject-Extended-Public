//
//  PaymentRequest.swift
//  NFT Market
//
//  Created by Dmitry on 28.01.2026.
//

import Foundation

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
