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
    
    static let mocks: [Nft] = [
        Nft(
            id: "1",
            name: "April",
            images: [Bundle.main.url(forResource: "nft_april", withExtension: "png", subdirectory: "Assets.xcassets/Images/nft_april.imageset") ?? URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!],
            rating: 3,
            description: "A 3D model of a mythical creature.",
            price: 2.5,
            author: "49",
            website: URL(string: "http://author.website") ?? URL(string: "https://example.com")!,
            createdAt: Date()
        ),
        Nft(
            id: "2",
            name: "Greena",
            images: [Bundle.main.url(forResource: "nft_greena", withExtension: "png", subdirectory: "Assets.xcassets/Images/nft_greena.imageset") ?? URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Greena/1.png")!],
            rating: 5,
            description: "A 3D model of a mythical creature.",
            price: 0.5,
            author: "49",
            website: URL(string: "http://author.website") ?? URL(string: "https://example.com")!,
            createdAt: Date()
        ),
        Nft(
            id: "3",
            name: "Spring",
            images: [Bundle.main.url(forResource: "nft_spring", withExtension: "png", subdirectory: "Assets.xcassets/Images/nft_spring.imageset") ?? URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Spring/1.png")!],
            rating: 4,
            description: "A 3D model of a mythical creature.",
            price: 1.78,
            author: "49",
            website: URL(string: "http://author.website") ?? URL(string: "https://example.com")!,
            createdAt: Date()
        ),
        Nft(
            id: "4",
            name: "Summer",
            images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!],
            rating: 5,
            description: "A 3D model of a mythical creature.",
            price: 3.2,
            author: "49",
            website: URL(string: "https://example.com")!,
            createdAt: Date()
        ),
        Nft(
            id: "5",
            name: "Winter",
            images: [URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Greena/1.png")!],
            rating: 4,
            description: "A 3D model of a mythical creature.",
            price: 0.9,
            author: "49",
            website: URL(string: "https://example.com")!,
            createdAt: Date()
        )
    ]
}


struct BasketItem: Identifiable, Sendable {
    let id: String
    let nft: Nft
    let quantity: Int
}


enum BasketSortOption: String, CaseIterable, Sendable {
    case name
    case price
    case rating
}


struct Currency: Identifiable, Sendable {
    let id: String
    let name: String
    let ticker: String
    let imageURL: URL
    
    static let mocks: [Currency] = [
        Currency(
            id: "1",
            name: "Bitcoin",
            ticker: "BTC",
            imageURL: URL(string: "https://example.com/btc")!
        ),
        Currency(
            id: "2",
            name: "Dogecoin",
            ticker: "DOGE",
            imageURL: URL(string: "https://example.com/doge")!
        ),
        Currency(
            id: "3",
            name: "Tether",
            ticker: "USDT",
            imageURL: URL(string: "https://example.com/usdt")!
        ),
        Currency(
            id: "4",
            name: "ApeCoin",
            ticker: "APE",
            imageURL: URL(string: "https://example.com/ape")!
        ),
        Currency(
            id: "5",
            name: "Ethereum",
            ticker: "ETH",
            imageURL: URL(string: "https://example.com/eth")!
        ),
        Currency(
            id: "6",
            name: "Solana",
            ticker: "SOL",
            imageURL: URL(string: "https://example.com/sol")!
        ),
        Currency(
            id: "7",
            name: "Cardano",
            ticker: "ADA",
            imageURL: URL(string: "https://example.com/ada")!
        ),
        Currency(
            id: "8",
            name: "Shiba Inu",
            ticker: "SHIB",
            imageURL: URL(string: "https://example.com/shib")!
        )
    ]
}
