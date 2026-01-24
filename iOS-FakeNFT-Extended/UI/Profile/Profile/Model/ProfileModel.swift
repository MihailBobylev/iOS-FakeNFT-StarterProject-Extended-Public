//
//  ProfileModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 20.01.2026.
//

import Foundation

struct ProfileModel: Identifiable {
    let id: UUID = UUID()
    
    var name: String
    var description: String
    var photo: URL?
    var website: URL?
    
    func getMockProfileModel() -> ProfileModel {
        ProfileModel(
            name: "Ivan Petrov",
            description: "Дизайнер из Казани, люблю цифровое искусство  и бейглы. В моей коллекции уже 100+ NFT,  и еще больше — на моём сайте. Открыт к коллаборациям.",
            photo: URL(string: "https://s0.rbk.ru/v6_top_pics/media/img/3/50/347328733549503.jpeg"),
            website: URL(string: "https://practicum.yandex.ru/ios-developer/?from=catalog")
        )
    }
}
