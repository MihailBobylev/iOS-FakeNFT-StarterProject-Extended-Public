//
//  UpdateLikedNFTRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 31.01.2026.
//

import Foundation

struct UpdateLikedNFTRequest: NetworkRequest {
    let nftIds: [String]
    
    var endpoint: URL? {
        var components = URLComponents(
            string: "\(RequestConstants.baseURL)/api/v1/profile/1"
        )
        
        let idsString = nftIds.joined(separator: ",")
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "likes", value: idsString)
        ]
        
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    var httpMethod: HttpMethod { .put }
}
