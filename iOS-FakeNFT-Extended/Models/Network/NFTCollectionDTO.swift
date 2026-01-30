//
//  NFTCollections.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 19.01.2026.
//

import Foundation

struct NFTCollectionDTO: Decodable, Hashable {
    let id: String?
    let name: String?
    let cover: String?
    let nfts: [String]
    let description: String?
    let author: String?
}
