import Foundation

protocol NftService {
    func fetchNFTCollections(page: Int, size: Int, sortBy: NFTCollectionSort?) async throws -> [NFTCollectionDTO]
    func loadNft(id: String) async throws -> Nft
}

@MainActor
final class NftServiceImpl: NftService {

    private let networkClient: NetworkClient
    private let storage: NftStorage
    private let nftCollectionStorage: NFTCollectionStorageProtocol

    init(
        networkClient: NetworkClient,
        storage: NftStorage,
        nftCollectionStorage: NFTCollectionStorageProtocol
    ) {
        self.storage = storage
        self.nftCollectionStorage = nftCollectionStorage
        self.networkClient = networkClient
    }

    func fetchNFTCollections(page: Int, size: Int, sortBy: NFTCollectionSort?) async throws -> [NFTCollectionDTO] {
        let request = NFTCollectionsRequest(page: page, size: size, sortBy: sortBy)
        let nftCollections: [NFTCollectionDTO] = try await networkClient.send(request: request)
        await nftCollectionStorage.saveNFTCollections(nftCollections)
        return nftCollections
    }
    
    func loadNft(id: String) async throws -> Nft {
        if let nft = await storage.getNft(with: id) {
            return nft
        }

        let request = NFTRequest(id: id)
        let nft: Nft = try await networkClient.send(request: request)
        await storage.saveNft(nft)
        return nft
    }
}
