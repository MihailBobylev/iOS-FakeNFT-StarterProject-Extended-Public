import Foundation

protocol NftStorage: AnyObject {
    func saveNft(_ nft: NFTCatalogCellModel) async
    func getNft(with id: String) async -> NFTCatalogCellModel?
    func changeFavoriteNFT(with id: String) async -> Bool
    func changeBasketNFT(with id: String) async -> Bool
}

// Пример простого актора, который сохраняет данные из сети
actor NftStorageImpl: NftStorage {
    private var storage: [String: NFTCatalogCellModel] = [:]

    func saveNft(_ nft: NFTCatalogCellModel) async {
        storage[nft.id] = nft
    }

    func getNft(with id: String) async -> NFTCatalogCellModel? {
        storage[id]
    }
    
    func changeFavoriteNFT(with id: String) async -> Bool {
        guard var nft = storage[id] else { return false }
        nft.isFavorite.toggle()
        storage[id] = nft
        return true
    }
    
    func changeBasketNFT(with id: String) async -> Bool {
        guard var nft = storage[id] else { return false }
        nft.inBasket.toggle()
        storage[id] = nft
        return true
    }
}
