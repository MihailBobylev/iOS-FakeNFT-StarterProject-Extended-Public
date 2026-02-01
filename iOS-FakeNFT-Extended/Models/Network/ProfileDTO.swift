//
//  ProfileDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

/// DTO профиля пользователя, получаемый с сервера
struct ProfileDTO: Codable, Equatable, Hashable {
    
    /// Уникальный идентификатор пользователя
    let id: String?

    /// Имя пользователя
    let name: String?

    /// URL аватара
    let avatar: String?

    /// Описание профиля
    let description: String?

    /// Ссылка на сайт пользователя
    let website: String?
    
    /// Массив nft
    let nfts: [String]
    
    /// Массив избранных nft
    let likes: [String]
}

