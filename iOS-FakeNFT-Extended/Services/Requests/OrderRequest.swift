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

/// PUT заказа. API принимает только application/x-www-form-urlencoded.
/// Массив nfts передаётся как повторяющийся ключ: nfts=id1&nfts=id2 (не nfts=id1,id2).
/// Пустая корзина: тело "" или "nfts=".
struct OrderUpdateRequest: NetworkRequest {
    let nfts: [String]

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }

    var httpMethod: HttpMethod { .put }

    var formEncodedBody: Data? {
        if nfts.isEmpty {
            return "".data(using: .utf8)
        }
        var components = URLComponents()
        components.queryItems = nfts.map { URLQueryItem(name: "nfts", value: $0) }
        guard let bodyString = components.percentEncodedQuery else { return nil }
        return bodyString.data(using: .utf8)
    }
}

/// POST /api/v1/orders/1 — выполнение заказа: в теле те же nfts, что в корзине; бэкенд добавляет их в профиль и очищает заказ.
struct OrderExecuteRequest: NetworkRequest {
    let nfts: [String]

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }

    var httpMethod: HttpMethod { .post }

    var formEncodedBody: Data? {
        if nfts.isEmpty {
            return "".data(using: .utf8)
        }
        var components = URLComponents()
        components.queryItems = nfts.map { URLQueryItem(name: "nfts", value: $0) }
        guard let bodyString = components.percentEncodedQuery else { return nil }
        return bodyString.data(using: .utf8)
    }
}
