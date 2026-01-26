//
//  ProfileDTO.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

struct ProfileDTO: Decodable, Equatable, Hashable {
    let id: String?
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
}

struct ProfileEncodable: Encodable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
}
