//
//  NFTCollectionsRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 20.01.2026.
//

import Foundation

struct NFTCollectionsRequest: NetworkRequest {
    let page: Int
    let size: Int
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections?page=\(page)&size=\(size)")
    }
}
