//
//  FetchLikedNFTRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 31.01.2026.
//

import Foundation

struct FetchLikedNFTRequest: NetworkRequest {
    let id: String?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id ?? "")")
    }
}
