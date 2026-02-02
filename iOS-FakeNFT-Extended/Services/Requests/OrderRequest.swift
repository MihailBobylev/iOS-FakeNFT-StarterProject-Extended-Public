//
//  OrderRequest.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import Foundation

struct OrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}

/// Ответ API: id заказа и массив ID NFT
struct OrderDTO: Decodable {
    let id: String
    let nfts: [String]
}
