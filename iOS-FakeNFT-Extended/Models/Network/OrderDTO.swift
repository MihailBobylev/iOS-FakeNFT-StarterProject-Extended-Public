//
//  OrderDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

struct OrderDTO: Codable {
    let id: String
    let nfts: [String]
}
