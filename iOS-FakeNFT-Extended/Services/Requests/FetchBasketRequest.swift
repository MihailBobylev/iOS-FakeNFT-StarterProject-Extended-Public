//
//  FetchBasketRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

struct FetchBasketRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}
