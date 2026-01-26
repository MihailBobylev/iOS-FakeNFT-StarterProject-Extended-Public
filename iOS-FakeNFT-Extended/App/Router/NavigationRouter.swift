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
    var deleteConfirmationItem: (nft: Nft, onDelete: () -> Void)?
    var sortPopupItem: (currentSort: BasketSortOption, onSelect: (BasketSortOption) -> Void)?
    
    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
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
