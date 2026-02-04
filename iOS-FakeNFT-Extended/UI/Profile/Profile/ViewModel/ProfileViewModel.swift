//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 20.01.2026.
//

import Foundation

@MainActor
@Observable
final class ProfileViewModel: Identifiable {
    let id: UUID = UUID()
    private var servicesAssembly: ServicesAssembly?
    var isLoading = false
    var requestError: ErrorType? = nil
    var profile: ProfileDTO = ProfileDTO(
        id: "",
        name: nil,
        avatar: nil,
        description: nil,
        website: nil,
        nfts: [],
        likes: []
    )
    
    func configure(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
}

extension ProfileViewModel: @MainActor Equatable {
    static func == (lhs: ProfileViewModel, rhs: ProfileViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension ProfileViewModel: @MainActor Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ProfileViewModel {
    func loadProfile() async {
        guard !isLoading else { return }
        
        isLoading = true
        requestError = .none
        
        profile = ProfileDTO(
            id: "",
            name: nil,
            avatar: nil,
            description: nil,
            website: nil,
            nfts: [],
            likes: []
        )
        
        do {
            guard let servicesAssembly else { return }
            let profile = try await servicesAssembly.nftService.fetchProfile()
            self.profile = ProfileDTO(
                id: profile.id,
                name: profile.name,
                avatar: profile.avatar,
                description: profile.description,
                website: profile.website,
                nfts: profile.nfts,
                likes: profile.likes
            )
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
}
