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
    let sortBy: NFTCollectionSort?
    
    var endpoint: URL? {
        var components = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/collections")
        
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size))
        ]
        
        if let sortBy {
            queryItems.append(
                URLQueryItem(name: "sortBy", value: sortBy.rawValue)
            )
        }
        
        components?.queryItems = queryItems
        return components?.url
    }
}
