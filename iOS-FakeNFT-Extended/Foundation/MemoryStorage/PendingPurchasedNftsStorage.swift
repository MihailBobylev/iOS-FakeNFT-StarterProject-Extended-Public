//
//  PendingPurchasedNftsStorage.swift
//  iOS-FakeNFT-Extended
//
//
//  Created by Dmitry on 04.02.2026.
//


import Foundation

/// Локальное хранилище NFT, купленных после оплаты, пока бэкенд не обновляет profile.nfts при PUT/execute.
protocol PendingPurchasedNftsStorageProtocol: AnyObject {
    func addPending(_ ids: [String]) async
    func getPending() async -> [String]
    func clearIncluded(in ids: [String]) async
}

actor PendingPurchasedNftsStorage: PendingPurchasedNftsStorageProtocol {
    private var pending = [String]()

    func addPending(_ ids: [String]) async {
        let set = Set(pending).union(ids)
        pending = Array(set)
    }

    func getPending() async -> [String] {
        pending
    }

    func clearIncluded(in ids: [String]) async {
        let set = Set(ids)
        pending = pending.filter { !set.contains($0) }
    }
}
