import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let profileStorage: ProfileStorageProtocol
    private let nftCollectionStorage: NFTCollectionStorageProtocol
    private let nftFavoriteStorage: NFTFavoriteStorageProtocol
    private let nftBasketStorage: NFTBasketStorageProtocol
    
    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        profileStorage: ProfileStorageProtocol,
        nftCollectionStorage: NFTCollectionStorageProtocol,
        nftFavoriteStorage: NFTFavoriteStorageProtocol,
        nftBasketStorage: NFTBasketStorageProtocol
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.profileStorage = profileStorage
        self.nftCollectionStorage = nftCollectionStorage
        self.nftFavoriteStorage = nftFavoriteStorage
        self.nftBasketStorage = nftBasketStorage
    }

    var nftService: NftServiceProtocol {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage,
            profileStorage: profileStorage,
            nftCollectionStorage: nftCollectionStorage,
            nftFavoriteStorage: nftFavoriteStorage,
            nftBasketStorage: nftBasketStorage
        )
    }

}
