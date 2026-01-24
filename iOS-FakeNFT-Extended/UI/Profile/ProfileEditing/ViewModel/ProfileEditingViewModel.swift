//
//  ProfileEditingViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 23.01.2026.
//

import Foundation

@Observable
final class ProfileEditingViewModel {
    
    var model: ProfileEditingModel
    
    init(viewModel: ProfileViewModel) {
        self.model = ProfileEditingModel(
            showPhotoActions: false,
            showEditAlert: false,
            showSaveButton: false,
            showBackAlert: false,
            imageURLText: viewModel.model.photo?.absoluteString ?? "",
            name: viewModel.model.name,
            description: viewModel.model.description,
            website: viewModel.model.website?.absoluteString ?? ""
        )
    }
}
