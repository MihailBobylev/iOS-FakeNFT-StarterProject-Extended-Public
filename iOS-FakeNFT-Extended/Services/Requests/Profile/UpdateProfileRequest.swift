//
//  ProfilePutRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

struct UpdateProfileRequest: NetworkRequest {
    let id: String?
    
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    
    var endpoint: URL? {
        var components = URLComponents(
            string: "\(RequestConstants.baseURL)/api/v1/profile/1"
        )
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "avatar", value: avatar),
            URLQueryItem(name: "description", value: description),
            URLQueryItem(name: "website", value: website),
            
        ]
        
        components?.queryItems = queryItems
        
        return components?.url
    }
    
    var dto: Encodable? {
        ProfileRequestDTO(
            name: name,
            avatar: avatar,
            description: description,
            website: website
        )
    }
    
    var httpMethod: HttpMethod { .put }
}
