//
//  NFTCollectionStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 20.01.2026.
//

import Foundation

protocol NFTCollectionStorageProtocol: AnyObject {
    func saveNFTCollections(_ nftCollections: [NFTCollectionDTO]) async
    func getNFTCollection(with id: String) async -> NFTCollectionDTO?
}

actor NFTCollectionStorage: NFTCollectionStorageProtocol {
    private var storage: [String: NFTCollectionDTO] = [:]

    func saveNFTCollections(_ nftCollections: [NFTCollectionDTO]) async {
        nftCollections.forEach { collection in
            guard let id = collection.id else { return }
            storage[id] = collection
        }
    }
    
    func getNFTCollection(with id: String) async -> NFTCollectionDTO? {
        storage[id]
    }
}
