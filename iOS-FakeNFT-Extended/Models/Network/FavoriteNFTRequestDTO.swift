//
//  FavoriteNFTRequestDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 31.01.2026.
//

/// DTO для обновления любимых нфт
struct FavoriteNFTRequestDTO: Encodable {

    /// ids
    let likes: [String?]
}
