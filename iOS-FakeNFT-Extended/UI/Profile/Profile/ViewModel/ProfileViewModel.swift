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
    private let servicesAssembly: ServicesAssembly
    var isLoading = false
    var requestError: ErrorType = .none
    var profile: ProfileDTO = ProfileDTO(
        id: nil,
        name: nil,
        avatar: nil,
        description: nil,
        website: nil
    )
    
    
    init(servicesAssembly: ServicesAssembly) {
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
            id: nil,
            name: nil,
            avatar: nil,
            description: nil,
            website: nil
        )
        
        do {
            let profile = try await servicesAssembly.nftService.fetchProfile()
            self.profile = profile
            isLoading = false
        } catch {
            isLoading = false
            requestError = .serverError
        }
    }
}
