//
//  AppRoute.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import Foundation

enum AppRoute: Hashable {
    case catalogDetails(nftCollection: NFTCollectionModel)
    case payment
    case paymentSuccess
    case editProfile
    case webView(url: URL)
}
