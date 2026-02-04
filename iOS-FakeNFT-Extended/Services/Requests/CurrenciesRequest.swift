//
//  CurrenciesRequest.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import Foundation

struct CurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
    }
}

/// DTO по API: id, title (название), name (тикер), image (URL)
struct CurrencyDTO: Decodable {
    let id: String
    let title: String
    let name: String
    let image: URL
}

extension CurrencyDTO {
    func toDomain() -> Currency {
        Currency(
            id: id,
            name: title,
            ticker: name,
            imageURL: image
        )
    }
}

struct Currency: Identifiable, Sendable {
    let id: String
    let name: String
    let ticker: String
    let imageURL: URL
}
