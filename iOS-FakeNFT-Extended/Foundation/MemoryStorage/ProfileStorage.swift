//
//  ProfileStorage.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

protocol ProfileStorageProtocol: AnyObject {
    func saveProfile(_ profile: ProfileDTO) async
    func getProfile() async -> ProfileDTO
}

actor ProfileStorage: ProfileStorageProtocol {
    
    // MARK: - Storage
    
    private var storage: ProfileDTO = ProfileDTO(
        id: "",
        name: nil,
        avatar: nil,
        description: nil,
        website: nil,
        nfts: [],
        likes: []
    )
    
    // MARK: - ProfileStorageProtocol
    
    func saveProfile(_ profile: ProfileDTO) async {
        self.storage = profile
    }
    
    func getProfile() async -> ProfileDTO {
        storage
    }
}
