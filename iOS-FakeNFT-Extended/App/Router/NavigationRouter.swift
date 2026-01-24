//
//  NavigationRouter.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import Observation
import SwiftUI

@Observable
final class NavigationRouter {

    var path = NavigationPath()
    var sheet: AppRoute?
    
    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    @ViewBuilder
    func destination(for route: AppRoute) -> some View {
        switch route {
        case let .catalogDetails(nftCollection):
            CatalogDetailsView(nftCollection: nftCollection)
        case .payment:
            EmptyView()
        case .paymentSuccess:
            EmptyView()
        case .editProfile:
            EmptyView()
        case .webView:
            EmptyView()
        }
    }
}
