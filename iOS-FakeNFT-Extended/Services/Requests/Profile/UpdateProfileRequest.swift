//
//  UpdateProfileRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

/// PUT профиля (редактирование). API принимает application/x-www-form-urlencoded в теле;
/// отправляется полный профиль (name, avatar, description, website, likes, nfts).
struct UpdateProfileRequest: NetworkRequest {
    let profile: ProfileDTO

    var httpMethod: HttpMethod { .put }

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }

    var formEncodedBody: Data? {
        var components = URLComponents()
        var items: [URLQueryItem] = [
            URLQueryItem(name: "name", value: profile.name ?? ""),
            URLQueryItem(name: "description", value: profile.description ?? ""),
            URLQueryItem(name: "avatar", value: profile.avatar ?? ""),
            URLQueryItem(name: "website", value: profile.website ?? "")
        ]
        for like in profile.likes {
            items.append(URLQueryItem(name: "likes", value: like))
        }
        for nft in profile.nfts {
            items.append(URLQueryItem(name: "nfts", value: nft))
        }
        components.queryItems = items
        guard let bodyString = components.percentEncodedQuery else { return "".data(using: .utf8) }
        return bodyString.data(using: .utf8)
    }
}
