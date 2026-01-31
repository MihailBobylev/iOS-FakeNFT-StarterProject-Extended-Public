import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    let nftService: NftService

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionStorage: NFTCollectionStorageProtocol,
        nftFavoriteStorage: NFTFavoriteStorageProtocol
    ) {
        self.nftService = NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage,
            nftCollectionStorage: nftCollectionStorage,
            nftFavoriteStorage: nftFavoriteStorage
        )
    }
}
