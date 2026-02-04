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

struct OrderDTO: Decodable {
    let id: String
    let nfts: [String]
}

struct OrderUpdateRequest: NetworkRequest {
    let nfts: [String]

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }

    var httpMethod: HttpMethod { .put }

    var formEncodedBody: Data? {
        let encoded = nfts.map { "nfts=\($0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0)" }
        return encoded.joined(separator: "&").data(using: .utf8)
    }
}
