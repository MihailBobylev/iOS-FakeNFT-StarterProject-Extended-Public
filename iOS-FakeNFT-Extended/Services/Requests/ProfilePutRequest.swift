//
//  ProfilePutRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

/// PUT профиля с обновлённым списком nfts (например, после оплаты — добавить купленные в «Мои NFT»).
struct UpdateProfileNftsRequest: NetworkRequest {
    let profile: ProfileDTO
    let nfts: [String]

    var httpMethod: HttpMethod { .put }

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var dto: Encodable? {
        ProfileDTO(
            id: profile.id,
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website,
            nfts: nfts,
            likes: profile.likes
        )
    }
}

struct UpdateFavoritesRequest: NetworkRequest {
    let likes: [String]?
    
    var httpMethod: HttpMethod { .put }
    
    var dto: Encodable? {
        ProfileDTO(
            id: "",
            name: nil,
            avatar: nil,
            description: nil,
            website: nil,
            nfts: [],
            likes: likes ?? []
        )
    }
    
    var endpoint: URL? {
        var components = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/profile/1")

        var queryItems: [URLQueryItem] = []
        
        queryItems.append(
            URLQueryItem(
                name: "likes",
                value: likes?.joined(separator: ",") ?? nil
            )
        )
        
        components?.queryItems = queryItems
        return components?.url
    }
}
