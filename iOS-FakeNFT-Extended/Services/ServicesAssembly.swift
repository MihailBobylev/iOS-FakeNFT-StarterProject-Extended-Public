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
    private let orderService: OrderService
    private let paymentServiceImpl: PaymentService
    private let currencyServiceImpl: CurrencyService
    
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
        self.orderService = OrderServiceImpl(networkClient: networkClient)
        self.paymentServiceImpl = PaymentServiceImpl(networkClient: networkClient)
        self.currencyServiceImpl = CurrencyServiceImpl(networkClient: networkClient)
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

    var basketService: BasketService {
        BasketServiceImpl(
            orderService: orderService,
            nftService: nftService
        )
    }

    var paymentService: PaymentService {
        paymentServiceImpl
    }

    var currencyService: CurrencyService {
        currencyServiceImpl
    }
}
