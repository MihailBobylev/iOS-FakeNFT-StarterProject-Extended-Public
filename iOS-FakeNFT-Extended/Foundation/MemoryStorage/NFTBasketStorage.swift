//
//  NFTBasketStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 31.01.2026.
//

import Foundation

protocol NFTBasketStorageProtocol {
    func saveBasket(_ ids: [String]) async
    func getBasket() async -> [String]
    func toggleBasket(_ id: String) async
    func inBasket(_ id: String) async -> Bool
}

actor NFTBasketStorage: NFTBasketStorageProtocol {
    private var storage = Set<String>()
    
    func saveBasket(_ ids: [String]) async {
        storage = Set(ids)
    }
    
    func getBasket() async -> [String] {
        Array(storage)
    }
    
    func inBasket(_ id: String) async -> Bool {
        storage.contains(id)
    }

    func toggleBasket(_ id: String) async {
        if storage.contains(id) {
            storage.remove(id)
        } else {
            storage.insert(id)
        }
    }
}
