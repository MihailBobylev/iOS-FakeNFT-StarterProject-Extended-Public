//
//  ProfileRequestDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 28.01.2026.
//

/// DTO для обновления профиля пользователя
struct ProfileRequestDTO: Encodable {

    /// Имя пользователя
    let name: String?

    /// URL аватара
    let avatar: String?

    /// Описание профиля
    let description: String?

    /// Ссылка на сайт пользователя
    let website: String?
}
