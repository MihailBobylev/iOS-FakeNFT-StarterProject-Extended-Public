//
//  BasketView.swift
//  NFT Market
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import SwiftUI

struct BasketView: View {
    @Environment(ServicesAssembly.self) private var services
    @State private var viewModel: BasketViewModel?
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Корзина")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(uiImage: UIImage(imageLiteralResourceName: "ic_sort"))
                    }
                }
            }
            .task {
                if viewModel == nil {
                    viewModel = BasketViewModel(basketService: services.basketService)
                    await viewModel?.loadItems()
                    if viewModel?.isEmpty == true {
                        await viewModel?.addTestData() // моковые пикчи
                    }
                }
            }
        }
    }
    
    private func contentView(viewModel: BasketViewModel) -> some View {
        List {
            ForEach(viewModel.items) { item in
                BasketItemRow(item: item)
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("Корзина пуста")
                .font(.title2Regular)
                .foregroundColor(.ypBlack)
            Spacer()
        }
    }
}

struct BasketItemRow: View {
    let item: BasketItem
    
    private func getImageName(for nftName: String) -> String? {
        switch nftName {
        case "April":
            return "nft_april"
        case "Greena":
            return "nft_greena"
        case "Spring":
            return "nft_spring"
        default:
            return nil
        }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Group {
                if let imageName = getImageName(for: item.nft.name) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if let url = item.nft.images.first {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
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
                    Text("Цена")
                        .font(.footnoteRegular13)
                        .foregroundColor(.ypBlack)
                    Text(String(format: "%.2f ETH", item.nft.price))
                        .font(.title3Bold)
                        .foregroundColor(.ypBlack)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(uiImage: UIImage(imageLiteralResourceName: "ic_basket_in"))
                    .renderingMode(.template)
                    .foregroundColor(.ypBlack)
                    .frame(width: 40, height: 40)
            }
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

#Preview {
    BasketView()
        .environment(ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl(),
            basketStorage: BasketStorageImpl()
        ))
}
