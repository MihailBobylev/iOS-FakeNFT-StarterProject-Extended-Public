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
            let currencies = [
                Currency(
                    id: "1",
                    name: "Bitcoin",
                    ticker: "BTC",
                    imageURL: URL(string: "https://example.com/btc")!
                ),
                Currency(
                    id: "2",
                    name: "Dogecoin",
                    ticker: "DOGE",
                    imageURL: URL(string: "https://example.com/doge")!
                ),
                Currency(
                    id: "3",
                    name: "Tether",
                    ticker: "USDT",
                    imageURL: URL(string: "https://example.com/usdt")!
                ),
                Currency(
                    id: "4",
                    name: "ApeCoin",
                    ticker: "APE",
                    imageURL: URL(string: "https://example.com/ape")!
                ),
                Currency(
                    id: "5",
                    name: "Ethereum",
                    ticker: "ETH",
                    imageURL: URL(string: "https://example.com/eth")!
                ),
                Currency(
                    id: "6",
                    name: "Solana",
                    ticker: "SOL",
                    imageURL: URL(string: "https://example.com/sol")!
                ),
                Currency(
                    id: "7",
                    name: "Cardano",
                    ticker: "ADA",
                    imageURL: URL(string: "https://example.com/ada")!
                ),
                Currency(
                    id: "8",
                    name: "Shiba Inu",
                    ticker: "SHIB",
                    imageURL: URL(string: "https://example.com/shib")!
                )
            ]
            PaymentView(viewModel: PaymentViewModel(currencies: currencies))
        case .paymentSuccess:
            EmptyView()
        case .editProfile:
            EmptyView()
        case .webView:
            EmptyView()
        }
    }
}
