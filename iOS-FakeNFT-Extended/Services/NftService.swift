import Foundation

protocol NftService {
    func fetchNFTCollections(page: Int, size: Int, sortBy: NFTCollectionSort?) async throws -> [NFTCollectionDTO]
    func loadNfts(ids: [String]) async throws -> [NFTCatalogCellModel]
    func loadNft(id: String) async throws -> NFTCatalogCellModel
    func loadFavoriteNFTs() async throws
    func changeFavoriteNFT(id: String) async throws -> Bool
    func changeBasketNFT(id: String) async -> Bool
}

@MainActor
final class NftServiceImpl: NftService {

    private let networkClient: NetworkClient
    private let storage: NftStorage
    private let nftCollectionStorage: NFTCollectionStorageProtocol
    private let nftFavoriteStorage: NFTFavoriteStorageProtocol

    init(
        networkClient: NetworkClient,
        storage: NftStorage,
        nftCollectionStorage: NFTCollectionStorageProtocol,
        nftFavoriteStorage: NFTFavoriteStorageProtocol
    ) {
        self.storage = storage
        self.nftCollectionStorage = nftCollectionStorage
        self.networkClient = networkClient
        self.nftFavoriteStorage = nftFavoriteStorage
    }

    func fetchNFTCollections(page: Int, size: Int, sortBy: NFTCollectionSort?) async throws -> [NFTCollectionDTO] {
        let request = NFTCollectionsRequest(page: page, size: size, sortBy: sortBy)
        let nftCollections: [NFTCollectionDTO] = try await networkClient.send(request: request)
        await nftCollectionStorage.saveNFTCollections(nftCollections)
        return nftCollections
    }
    
    func loadNfts(ids: [String]) async throws -> [NFTCatalogCellModel] {
        try await withThrowingTaskGroup(of: (Int, NFTCatalogCellModel).self) { group in
            for (index, id) in ids.enumerated() {
                group.addTask {
                    let nft = try await self.loadNft(id: id)
                    return (index, nft)
                }
            }

            var result = Array<NFTCatalogCellModel?>(repeating: nil, count: ids.count)

            for try await (index, nft) in group {
                result[index] = nft
            }

            return result.compactMap { $0 }
        }
    }

    func loadNft(id: String) async throws -> NFTCatalogCellModel {
        if let nft = await storage.getNft(with: id) {
            return nft
        }

        let request = NFTRequest(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        let isFavorite = await nftFavoriteStorage.isFavorite(nft.id)
        
        let nftModel = NFTCatalogCellModel(nft: nft, isFavorite: isFavorite)
        await storage.saveNft(nftModel)
        return nftModel
    }
    
    func loadFavoriteNFTs() async throws {
        let request = FetchProfileRequest()
        let profile: ProfileDTO = try await networkClient.send(request: request)

        await nftFavoriteStorage.saveFavorite(profile.likes)
    }
    
    func changeFavoriteNFT(id: String) async throws -> Bool {
        guard await storage.changeFavoriteNFT(with: id) else { return false }
        await nftFavoriteStorage.toggleFavorite(id)
        let favorites = await nftFavoriteStorage.getFavorites()
        let request = UpdateFavoritesRequest(
            likes: favorites
        )
        let _ = try await networkClient.send(request: request)
        return true
    }
    
    func changeBasketNFT(id: String) async -> Bool {
        await storage.changeBasketNFT(with: id)
    }
}
