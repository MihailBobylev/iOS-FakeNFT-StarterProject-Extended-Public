//
//  PaymentSuccessViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Dmitry on 06.02.2026.
//

import Foundation

@MainActor
@Observable
final class PaymentSuccessViewModel {
    private let services: ServicesAssembly
    private let router: NavigationRouter
    
    var isClosing = false
    
    init(services: ServicesAssembly, router: NavigationRouter) {
        self.services = services
        self.router = router
    }
    
    func closeAndRefresh() async {
        guard !isClosing else { return }
        isClosing = true
        defer { isClosing = false }
        
        try? await services.basketService.clear()
        try? await services.nftService.loadBasket()
        _ = try? await services.nftService.fetchProfile()
        router.popToRoot()
    }
}

