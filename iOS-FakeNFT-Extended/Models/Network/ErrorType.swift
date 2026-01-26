//
//  ErrorType.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 25.01.2026.
//

import Foundation

enum ErrorType {
    case serverError
    case none
    
    var title: String {
        return switch self {
        case .serverError:
            "Ошибка сервера"
        case .none:
            ""
        }
    }
}
