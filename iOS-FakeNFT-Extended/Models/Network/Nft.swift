//
//  Nft.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

struct Nft: Decodable, Identifiable, Sendable {
    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let website: URL
    let createdAt: Date
}

/// Модель записи NFT в корзине
struct BasketItem: Identifiable, Sendable {
    let id: String
    let nft: Nft
    let quantity: Int
}

/// Варианты сортировки корзины
enum BasketSortOption: String, CaseIterable, Sendable {
    case name
    case price
    case rating
}

/// Модель валюты для экрана оплаты
struct Currency: Identifiable, Sendable {
    let id: String
    let name: String
    let ticker: String
    let imageURL: URL
}
