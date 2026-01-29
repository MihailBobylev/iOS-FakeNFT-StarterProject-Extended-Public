import Foundation

protocol NftService {
    func fetchNFTCollections(page: Int, size: Int, sortBy: NFTCollectionSort?) async throws -> [NFTCollectionDTO]
    func loadNfts(ids: [String]) async throws -> [Nft]
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
    
    func loadNfts(ids: [String]) async throws -> [Nft] {
        try await withThrowingTaskGroup(of: (Int, Nft).self) { group in
            for (index, id) in ids.enumerated() {
                group.addTask {
                    let nft = try await self.loadNft(id: id)
                    return (index, nft)
                }
            }

            var result = Array<Nft?>(repeating: nil, count: ids.count)

            for try await (index, nft) in group {
                result[index] = nft
            }

            return result.compactMap { $0 }
        }
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
