import Foundation

@Observable
@MainActor
final class ServicesAssembly {

    private let networkClient: NetworkClient
    private let nftStorage: NftStorage
    private let basketStorage: BasketStorage

    init(
        networkClient: NetworkClient,
        nftStorage: NftStorage,
        basketStorage: BasketStorage
    ) {
        self.networkClient = networkClient
        self.nftStorage = nftStorage
        self.basketStorage = basketStorage
    }

    var nftService: NftService {
        NftServiceImpl(
            networkClient: networkClient,
            storage: nftStorage
        )
    }

    var basketService: BasketService {
        BasketServiceImpl(
            storage: basketStorage
        )
    }

    var paymentService: PaymentService {
        PaymentServiceImpl(
            networkClient: networkClient
        )
    }

    var currencyService: CurrencyService {
        CurrencyServiceImpl(networkClient: networkClient)
    }
}
