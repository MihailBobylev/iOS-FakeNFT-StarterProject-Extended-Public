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
        guard let servicesAssembly, !isLoading else { return }
        
        isLoading = true
        requestError = .none
        
        do {
            let profile = try await servicesAssembly.nftService.fetchProfile()
            self.profile = profile
        } catch {
            requestError = .serverError
        }
        
        isLoading = false
    }
}
