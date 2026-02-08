//
//  NavigationRouter.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import Observation
import SwiftUI

enum AppTab: Int {
    case profile = 0, catalog, basket
}

@Observable
final class NavigationRouter {

    var path = NavigationPath()
    var selectedTab: AppTab = .profile
    var sheet: AppRoute?
    var deleteConfirmationItem: (item: NFTCatalogCellModel, onDelete: () -> Void)?
    var sortPopupItem: (currentSort: BasketSortOption, onSelect: (BasketSortOption) -> Void)?
    
    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func showDeleteConfirmation(item: NFTCatalogCellModel, onDelete: @escaping () -> Void) {
        deleteConfirmationItem = (item: item, onDelete: onDelete)
    }
    
    func hideDeleteConfirmation() {
        deleteConfirmationItem = nil
    }
    
    func showSortPopup(currentSort: BasketSortOption, onSelect: @escaping (BasketSortOption) -> Void) {
        sortPopupItem = (currentSort: currentSort, onSelect: onSelect)
    }
    
    func hideSortPopup() {
        sortPopupItem = nil
    }
    
    @ViewBuilder
    func destination(for route: AppRoute) -> some View {
        switch route {
        case let .catalogDetails(nftCollection):
            CatalogDetailsView(nftCollection: nftCollection)
        case .payment:
            PaymentView()
        case .paymentSuccess:
            PaymentSuccessView()
        case .editProfile:
            EmptyView()
        case let .webView(url):
            WebViewScreen(url: url)
        case let .myNFT(profile):
            MyNFTView(profile: profile)
        case let .favoriteNFT(profile):
            FavoriteNFTView(profile: profile)
        case let .profileEditing(profile):
            ProfileEditingView(profile: profile)
        }
    }
}

