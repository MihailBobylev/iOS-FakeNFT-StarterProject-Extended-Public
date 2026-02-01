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
    
    var dto: Encodable? {
        OrderDTO(
            id: "",
            nfts: nfts
        )
    }

    var endpoint: URL? {
        var components = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/orders/1")

        var queryItems: [URLQueryItem] = []
        
        queryItems.append(
            URLQueryItem(
                name: "nfts",
                value: nfts.joined(separator: ",")
            )
        )
        
        components?.queryItems = queryItems
        return components?.url
    }
}
