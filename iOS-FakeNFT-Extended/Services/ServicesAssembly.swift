import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let nftCollectionStorage: NFTCollectionStorageProtocol

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        nftCollectionStorage: NFTCollectionStorageProtocol
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.nftCollectionStorage = nftCollectionStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage,
            nftCollectionStorage: nftCollectionStorage
        )
    }
}
