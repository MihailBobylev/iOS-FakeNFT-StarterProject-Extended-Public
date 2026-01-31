//
//  ProfileDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

struct ProfileDTO: Codable {
    let id: String
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let nfts: [Nft]
    let likes: [String]
}
