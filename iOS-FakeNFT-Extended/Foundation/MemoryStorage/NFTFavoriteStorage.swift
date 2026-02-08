//
//  NFTFavoriteStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

protocol NFTFavoriteStorageProtocol {
    func saveFavorite(_ ids: [String]) async
    func getFavorites() async -> [String]
    func toggleFavorite(_ id: String) async
    func isFavorite(_ id: String) async -> Bool
}

actor NFTFavoriteStorage: NFTFavoriteStorageProtocol {
    private var storage = Set<String>()
    
    func saveFavorite(_ ids: [String]) async {
        storage = Set(ids)
    }
    
    func getFavorites() async -> [String] {
        Array(storage)
    }
    
    func isFavorite(_ id: String) async -> Bool {
        storage.contains(id)
    }

    func toggleFavorite(_ id: String) async {
        if storage.contains(id) {
            storage.remove(id)
        } else {
            storage.insert(id)
        }
    }
}
