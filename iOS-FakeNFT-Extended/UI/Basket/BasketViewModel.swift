//
//  BasketViewModel.swift
//  NFT Market
//
//  Created by Dmitry on 21.01.2026.
//

import Foundation

@Observable
@MainActor
final class BasketViewModel {
    
    var items: [BasketItem] = []
    var isLoading = false
    var isEmpty: Bool {
        items.isEmpty && !isLoading
    }
    
    private let basketService: BasketService
    
    init(basketService: BasketService) {
        self.basketService = basketService
    }
    
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }
        
        items = await basketService.loadItems()
    }
    
    var totalCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.nft.price * Double($1.quantity)) }
    }
    
    func addTestData() async {
        let testNfts = createTestNfts()
        for nft in testNfts {
            await basketService.add(nft: nft)
        }
        await loadItems()
    }
    // моковые картинки
    private func createTestNfts() -> [Nft] {
        [
            Nft(
                id: "1",
                name: "April",
                images: [Bundle.main.url(forResource: "nft_april", withExtension: "png", subdirectory: "Assets.xcassets/Images/nft_april.imageset") ?? URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!],
                rating: 5,
                description: "A 3D model of a mythical creature.",
                price: 1.78,
                author: "49",
                website: URL(string: "http://author.website")!,
                createdAt: Date()
            ),
            Nft(
                id: "2",
                name: "Greena",
                images: [Bundle.main.url(forResource: "nft_greena", withExtension: "png", subdirectory: "Assets.xcassets/Images/nft_greena.imageset") ?? URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Greena/1.png")!],
                rating: 5,
                description: "A 3D model of a mythical creature.",
                price: 1.78,
                author: "49",
                website: URL(string: "http://author.website")!,
                createdAt: Date()
            ),
            Nft(
                id: "3",
                name: "Spring",
                images: [Bundle.main.url(forResource: "nft_spring", withExtension: "png", subdirectory: "Assets.xcassets/Images/nft_spring.imageset") ?? URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Spring/1.png")!],
                rating: 5,
                description: "A 3D model of a mythical creature.",
                price: 1.78,
                author: "49",
                website: URL(string: "http://author.website")!,
                createdAt: Date()
            )
        ]
    }
}
