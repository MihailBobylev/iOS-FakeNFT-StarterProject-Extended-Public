//
//  ProfilePutRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

/// PUT профиля с обновлённым списком nfts. API принимает application/x-www-form-urlencoded в теле.
/// Отправляется полный профиль (name, avatar, description, website, likes, nfts).
/// nftsRepeated: true = nfts=id1&nfts=id2, false = nfts=id1,id2 (один ключ).
struct UpdateProfileNftsRequest: NetworkRequest {
    let profile: ProfileDTO
    let nfts: [String]
    let nftsRepeated: Bool

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
        if nftsRepeated {
            for nft in nfts {
                items.append(URLQueryItem(name: "nfts", value: nft))
            }
        } else {
            items.append(URLQueryItem(name: "nfts", value: nfts.joined(separator: ",")))
        }
        components.queryItems = items
        guard let bodyString = components.percentEncodedQuery else { return "".data(using: .utf8) }
        return bodyString.data(using: .utf8)
    }
}

/// PUT профиля с обновлёнными избранными. API принимает application/x-www-form-urlencoded;
/// отправляется полный профиль (name, avatar, description, website, likes, nfts), чтобы бэкенд не затирал поля.
struct UpdateFavoritesRequest: NetworkRequest {
    let profile: ProfileDTO
    let likes: [String]

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
        for like in likes {
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
