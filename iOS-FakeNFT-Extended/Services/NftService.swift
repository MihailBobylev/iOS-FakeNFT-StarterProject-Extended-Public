import Foundation

protocol NftServiceProtocol {
    func loadNft(id: String) async throws -> Nft
    func fetchProfile() async throws -> ProfileDTO
    func updateProfile(with profile: ProfileDTO) async throws
}

@MainActor
final class NftServiceImpl: NftServiceProtocol {

    private let networkClient: NetworkClient
    private let storage: NftStorage
    private let profileStorage: ProfileStorageProtocol

    init(
        networkClient: NetworkClient,
        storage: NftStorage,
        profileStorage: ProfileStorageProtocol
    ) {
        self.storage = storage
        self.networkClient = networkClient
        self.profileStorage = profileStorage
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
    
    func fetchProfile() async throws -> ProfileDTO {
        let request = FetchProfileRequest()
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await profileStorage.saveProfile(profile)
        return profile
    }
    
    func updateProfile(with profile: ProfileDTO) async throws {
        let request = UpdateProfileRequest(
            id: profile.id,
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website
        )
        
        let profile: ProfileDTO = try await networkClient.send(request: request)
        await profileStorage.saveProfile(profile)
    }
}
