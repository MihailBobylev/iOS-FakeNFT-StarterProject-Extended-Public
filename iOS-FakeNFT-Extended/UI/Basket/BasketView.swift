//
//  BasketView.swift
//  NFT Market
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import Kingfisher
import SwiftUI

private func priceLabel(_ price: Decimal) -> String {
    "\(NSDecimalNumber(decimal: price).stringValue) ETH"
}

struct BasketView: View {
    @Environment(ServicesAssembly.self) private var services
    @Environment(NavigationRouter.self) private var router
    @State private var viewModel: BasketViewModel?
    @State private var showSortSheet = false
    
    private enum Constants {
        static let emptyBasketText = "Корзина пуста"
        static let priceLabel = "Цена"
        static let sortAlertTitle = "Сортировка"
        static let priceSortTitle = "По цене"
        static let ratingSortTitle = "По рейтингу"
        static let nameSortTitle = "По названию"
        static let cancelSortButtonTitle = "Закрыть"
    }
    
    private func canChangeSort(_ viewModel: BasketViewModel) -> Bool {
        !viewModel.isLoading
    }
    
    var body: some View {
        Group {
            if let viewModel = viewModel {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.isEmpty {
                    emptyStateView
                } else {
                    contentView(viewModel: viewModel)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            if viewModel == nil {
                viewModel = BasketViewModel(basketService: services.basketService)
                await viewModel?.loadItems()
            }
        }
        .onChange(of: router.path.count) { _, newCount in
            if newCount == 0, viewModel != nil {
                Task { await viewModel?.loadItems() }
            }
        }
        .onChange(of: router.selectedTab) { _, newTab in
            if newTab == .basket, viewModel != nil {
                Task { await viewModel?.loadItems() }
            }
        }
        .onAppear {
            if router.path.isEmpty, viewModel != nil {
                Task { await viewModel?.loadItems() }
            }
        }
    }
    
    private func contentView(viewModel: BasketViewModel) -> some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    showSortSheet = true
                } label: {
                    Image(.icSort)
                        .renderingMode(.template)
                        .foregroundColor(.ypBlack)
                }
                .opacity(canChangeSort(viewModel) ? 1 : 0.4)
                .disabled(!canChangeSort(viewModel))
                .sortDialog(
                    isPresented: $showSortSheet,
                    dialog: SortConfirmationDialog(
                        title: Constants.sortAlertTitle,
                        options: [
                            SortOption(title: Constants.priceSortTitle) {
                                viewModel.setSortOption(.price)
                            },
                            SortOption(title: Constants.ratingSortTitle) {
                                viewModel.setSortOption(.rating)
                            },
                            SortOption(title: Constants.nameSortTitle) {
                                viewModel.setSortOption(.name)
                            }
                        ]
                    ),
                    cancelButtonTitle: Constants.cancelSortButtonTitle
                )
            }
            .padding(.horizontal, 9)
            
            List {
                ForEach(viewModel.items) { item in
                    BasketItemRow(
                        item: item,
                        onDelete: {
                            router.showDeleteConfirmation(item: item.nft) {
                                Task {
                                    await viewModel.removeItem(id: item.id)
                                    router.hideDeleteConfirmation()
                                }
                            }
                        },
                        onSelect: {
                            router.push(.payment)
                        }
                    )
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
            BasketBottomPanel(viewModel: viewModel, router: router)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 8) {
            Spacer()
            Text(Constants.emptyBasketText)
                .font(.title2Regular)
                .foregroundColor(.ypBlack)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BasketItemRow: View {
    let item: BasketItem
    let onDelete: () -> Void
    let onSelect: () -> Void
    
    private enum Constants {
        static let priceLabel = "Цена"
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onSelect) {
                HStack(spacing: 20) {
                    Group {
                        if let cover = item.nft.cover,
                           let url = URL(string: cover) {
                            KFImage(url)
                                .placeholder { ProgressView() }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 108, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.nft.name)
                                .font(.title3Bold)
                                .foregroundColor(.ypBlack)
                            
                            RatingView(rating: item.nft.rating)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(Constants.priceLabel)
                                .font(.footnoteRegular13)
                                .foregroundColor(.ypBlack)
                            if let priceDecimal = Decimal(string: item.nft.price) {
                                Text(priceLabel(priceDecimal))
                                    .font(.title3Bold)
                                    .foregroundColor(.ypBlack)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .trailing) {
                Button(action: onDelete) {
                    Image(.icBasketIn)
                        .renderingMode(.template)
                        .foregroundColor(.ypBlack)
                        .frame(width: 20, height: 20)
                        .offset(x: -20)
                }
                .buttonStyle(.plain)
            }
            .frame(width: 80, height: 80, alignment: .trailing)
            .contentShape(Rectangle())
        }
    }
}

struct RatingView: View {
    let rating: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .foregroundColor(index < rating ? .yellow : .gray)
                    .font(.system(size: 12))
            }
        }
    }
}

struct BasketBottomPanel: View {
    let viewModel: BasketViewModel
    let router: NavigationRouter
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("\(viewModel.totalCount) NFT")
                            .font(.footnoteRegular15)
                            .foregroundColor(.ypBlack)
                    }
                    Text(priceLabel(viewModel.totalPrice))
                        .font(.title3Bold)
                        .foregroundColor(.ypGreen)
                }
                
                Spacer()
                
                Button(action: {
                    router.push(.payment)
                }) {
                    Text("К оплате")
                        .font(.title3Bold)
                        .foregroundColor(.ypWhite)
                        .frame(width: 240, height: 44)
                        .background(Color.ypBlack)
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 16)
        .background(Color.ypLightGray)
        .clipShape(UnevenRoundedRectangle(
            topLeadingRadius: 12,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: 12
        ))
    }
}

#Preview {
    BasketView()
        .environment(
            ServicesAssembly(
                networkClient: DefaultNetworkClient(),
                nftStorage: NftStorageImpl(),
                profileStorage: ProfileStorage(),
                nftCollectionStorage: NFTCollectionStorage(),
                nftFavoriteStorage: NFTFavoriteStorage(),
                nftBasketStorage: NFTBasketStorage()
            )
        )
}
