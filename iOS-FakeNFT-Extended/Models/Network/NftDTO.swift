//
//  NftDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 30.01.2026.
//

/// DTO nft
struct NftDTO: Identifiable, Decodable, Equatable, Hashable {
    
    /// Уникальный идентификатор nft
    let id: String?
    
    /// Создан
    let createdAt: String?

    /// Имя пользователя
    let name: String?
    
    /// Список картинок
    let images: [String?]
    
    /// Рейтинг nft
    let rating: Int?
    
    /// Описание nft
    let description: String?

    /// Цена nft
    let price: Double?
    
    /// Автор nft
    let author: String?

    /// Ссылка на сайт nft
    let website: String?
}

