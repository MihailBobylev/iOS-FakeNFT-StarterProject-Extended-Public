//
//  MyNFTRequestDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 01.02.2026.
//

/// DTO для обновления моих нфт
struct MyNFTRequestDTO: Encodable {

    /// ids
    let nfts: [String?]
}
