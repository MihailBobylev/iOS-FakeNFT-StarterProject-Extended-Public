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
    var deleteConfirmationItem: (nft: Nft, onDelete: () -> Void)?
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
    
    func showDeleteConfirmation(nft: Nft, onDelete: @escaping () -> Void) {
        deleteConfirmationItem = (nft: nft, onDelete: onDelete)
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
        case .catalogDetails:
            EmptyView()
        case .payment:
            PaymentView()
        case .paymentSuccess:
            PaymentSuccessView()
        case .editProfile:
            EmptyView()
        case .webView:
            TermsOfServiceView()
        }
    }
}
