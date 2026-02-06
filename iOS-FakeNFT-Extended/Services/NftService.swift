import Foundation

protocol NftServiceProtocol {
    func fetchProfile() async throws -> ProfileDTO
    func updateProfile(with profile: ProfileDTO) async throws
    func updateProfileNfts(profile: ProfileDTO, nfts: [String]) async throws
    func updateLikedNFT(with ids: [String], with id: String) async throws
    func fetchNFT(with id: String) async throws -> NftDTO
    func fetchNFTCollections(page: Int, size: Int, sortBy: NFTCollectionSort?) async throws -> [NFTCollectionDTO]
    func loadNfts(ids: [String]) async throws -> [NFTCatalogCellModel]
    func loadNft(id: String) async throws -> NFTCatalogCellModel
    func loadFavoriteNFTs() async throws
    func changeFavoriteNFT(id: String) async throws -> Bool
    func loadBasket() async throws
    func changeBasketNFT(id: String) async throws -> Bool

}

@MainActor
final class NftServiceImpl: NftServiceProtocol {

    private let networkClient: NetworkClient
    private let storage: NftStorage
    private let profileStorage: ProfileStorageProtocol
    private let nftCollectionStorage: NFTCollectionStorageProtocol
    private let nftFavoriteStorage: NFTFavoriteStorageProtocol
    private let nftBasketStorage: NFTBasketStorageProtocol

    init(
        networkClient: NetworkClient,
        storage: NftStorage,
        profileStorage: ProfileStorageProtocol,
        nftCollectionStorage: NFTCollectionStorageProtocol,
        nftFavoriteStorage: NFTFavoriteStorageProtocol,
        nftBasketStorage: NFTBasketStorageProtocol
    ) {
        self.storage = storage
        self.nftCollectionStorage = nftCollectionStorage
        self.networkClient = networkClient
        self.profileStorage = profileStorage
        self.nftFavoriteStorage = nftFavoriteStorage
        self.nftBasketStorage = nftBasketStorage
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
        let inBasket = await nftBasketStorage.inBasket(nft.id)
        
        let nftModel = NFTCatalogCellModel(
            nft: nft,
            isFavorite: isFavorite,
            inBasket: inBasket
        )
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
        let profile = try await fetchProfile()
        let request = UpdateFavoritesRequest(profile: profile, likes: favorites)
        let updated: ProfileDTO = try await networkClient.send(request: request)
        await profileStorage.saveProfile(updated)
        return true
    }
    
    func loadBasket() async throws {
        let request = FetchBasketRequest()
        let order: OrderDTO = try await networkClient.send(request: request)
        
        await nftBasketStorage.saveBasket(order.nfts)
    }
    
    func changeBasketNFT(id: String) async throws -> Bool {
        guard await storage.changeBasketNFT(with: id) else { return false }
        await nftBasketStorage.toggleBasket(id)
        let basket = await nftBasketStorage.getBasket()
        let request = PUTBasketRequest(
            nfts: basket
        )
        let _ = try await networkClient.send(request: request)
        return true
    }
    
    func fetchProfile() async throws -> ProfileDTO {
        let request = FetchProfileRequest()
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await profileStorage.saveProfile(profile)
        return profile
    }
    
    func updateProfile(with profile: ProfileDTO) async throws {
        let request = UpdateProfileRequest(profile: profile)
        let updated: ProfileDTO = try await networkClient.send(request: request)
        await profileStorage.saveProfile(updated)
    }

    func updateProfileNfts(profile: ProfileDTO, nfts: [String]) async throws {
        do {
            try await sendUpdateProfileNfts(profile: profile, nfts: nfts, nftsRepeated: true)
        } catch NetworkClientError.httpStatusCode(400), NetworkClientError.httpStatusCode(415) {
            try await sendUpdateProfileNfts(profile: profile, nfts: nfts, nftsRepeated: false)
        } catch {
            throw error
        }
    }

    private func sendUpdateProfileNfts(profile: ProfileDTO, nfts: [String], nftsRepeated: Bool) async throws {
        let request = UpdateProfileNftsRequest(profile: profile, nfts: nfts, nftsRepeated: nftsRepeated)
        do {
            let updated: ProfileDTO = try await networkClient.send(request: request)
            await profileStorage.saveProfile(updated)
        } catch NetworkClientError.parsingError {
            let fresh = try await fetchProfile()
            await profileStorage.saveProfile(fresh)
        } catch {
            let fresh = try await fetchProfile()
            await profileStorage.saveProfile(fresh)
            throw error
        }
    }

    func updateLikedNFT(with ids: [String], with id: String) async throws {
        let profile = try await fetchProfile()
        let request = UpdateFavoritesRequest(profile: profile, likes: ids)
        let updated: ProfileDTO = try await networkClient.send(request: request)
        await profileStorage.saveProfile(updated)
        let _ = await storage.changeFavoriteNFT(with: id)
        await nftFavoriteStorage.saveFavorite(updated.likes)
    }
    
    func fetchNFT(with id: String) async throws -> NftDTO {
        let request = FetchNFTRequest(id: id)
        let nft: NftDTO = try await networkClient.send(request: request)
        return nft
    }
}
