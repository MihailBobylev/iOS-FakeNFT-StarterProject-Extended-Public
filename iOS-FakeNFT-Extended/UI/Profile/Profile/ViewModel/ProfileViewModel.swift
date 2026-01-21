//
//  ProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 20.01.2026.
//

import Foundation

@Observable
final class ProfileViewModel: Identifiable {
    let id: UUID = UUID()
    
    var model: ProfileModel = ProfileModel(name: "", description: "")
    
    init() {
        self.model = getMockProfileModel()
    }
}

extension ProfileViewModel: Equatable {
    static func == (lhs: ProfileViewModel, rhs: ProfileViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension ProfileViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ProfileViewModel {
    func getMockProfileModel() -> ProfileModel {
        ProfileModel(
            name: "Ivan Petrov",
            description: "Дизайнер из Казани, люблю цифровое искусство  и бейглы. В моей коллекции уже 100+ NFT,  и еще больше — на моём сайте. Открыт к коллаборациям.",
            photo: URL(string: "https://s0.rbk.ru/v6_top_pics/media/img/3/50/347328733549503.jpeg"),
            website: URL(string: "https://practicum.yandex.ru/ios-developer/?from=catalog")
        )
    }
}
