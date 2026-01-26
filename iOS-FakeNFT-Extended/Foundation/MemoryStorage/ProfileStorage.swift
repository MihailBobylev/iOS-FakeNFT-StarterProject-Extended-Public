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
    private var storage: ProfileDTO = ProfileDTO(
        id: nil,
        name: nil,
        avatar: nil,
        description: nil,
        website: nil
    )
    func saveProfile(_ profile: ProfileDTO) async {
        self.storage = profile
    }
    func getProfile() async -> ProfileDTO {
        storage
    }
}
