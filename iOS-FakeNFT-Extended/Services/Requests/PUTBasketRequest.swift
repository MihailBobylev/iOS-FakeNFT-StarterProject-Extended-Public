//
//  PUTBasketRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

struct PUTBasketRequest: NetworkRequest {
    let nfts: [String]
    
    var httpMethod: HttpMethod { .put }
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    
    /// API: form-urlencoded с повторяющимся ключом nfts=id1&nfts=id2 (пустая корзина: тело "").
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
