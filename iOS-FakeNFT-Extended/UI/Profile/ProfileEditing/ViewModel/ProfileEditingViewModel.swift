//
//  ProfileEditingViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 23.01.2026.
//

import Foundation

@MainActor
@Observable
final class ProfileEditingViewModel {
    
    var model: ProfileEditingModel
    
    init(profile: ProfileDTO) {
        self.model = ProfileEditingModel(
            showPhotoActions: false,
            showEditAlert: false,
            showSaveButton: false,
            showBackAlert: false,
            imageURLText: profile.avatar ?? "",
            name: profile.name ?? "",
            description: profile.description ?? "",
            website: profile.website ?? ""
        )
    }
}
