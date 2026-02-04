//
//  PendingPurchasedNftsStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Dmitry on 04.02.2026.
//

import Foundation

/// Локальное хранилище NFT, купленных после оплаты (бэкенд не обновляет profile.nfts).
/// Сохраняется в UserDefaults, чтобы купленные NFT отображались после перезапуска приложения.
protocol PendingPurchasedNftsStorageProtocol: AnyObject {
    func addPending(_ ids: [String]) async
    func getPending() async -> [String]
    func clearIncluded(in ids: [String]) async
}

private let pendingPurchasedNftsKey = "PendingPurchasedNfts"

actor PendingPurchasedNftsStorage: PendingPurchasedNftsStorageProtocol {
    private var pending: [String] {
        get {
            (UserDefaults.standard.array(forKey: pendingPurchasedNftsKey) as? [String]) ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: pendingPurchasedNftsKey)
        }
    }

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
