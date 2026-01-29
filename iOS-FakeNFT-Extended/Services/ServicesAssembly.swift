import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    let nftService: NftService

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionStorage: NFTCollectionStorageProtocol
    ) {
        self.nftService = NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage,
            nftCollectionStorage: nftCollectionStorage
        )
    }
}
