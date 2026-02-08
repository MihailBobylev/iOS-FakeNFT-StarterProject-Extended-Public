//
//  FetchNFTRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 01.02.2026.
//

import Foundation

struct FetchNFTRequest: NetworkRequest {
    let id: String
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id)")
    }
}
