//
//  ErrorType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 20.01.2026.
//

import Foundation

enum ErrorType: Error {
    case serverError

    var title: String {
        switch self {
        case .serverError: "Ошибка сервера"
        }
    }
}
