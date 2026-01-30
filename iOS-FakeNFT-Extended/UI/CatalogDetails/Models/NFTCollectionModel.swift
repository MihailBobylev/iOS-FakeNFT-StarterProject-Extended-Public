//
//  NFTCollectionModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 29.01.2026.
//

import Foundation

struct NFTCollectionModel: Identifiable, Hashable {
    let id: String?
    let name: String?
    let cover: String?
    let nfts: [String]
    let description: String?
    let author: String?
    let website = "https://practicum.yandex.ru/ios-developer/"
}

extension NFTCollectionModel {
    init(collectionDTO: NFTCollectionDTO) {
        self.id = collectionDTO.id
        self.name = collectionDTO.name
        self.cover = collectionDTO.cover
        self.nfts = collectionDTO.nfts
        self.description = collectionDTO.description
        self.author = collectionDTO.author
    }
}
