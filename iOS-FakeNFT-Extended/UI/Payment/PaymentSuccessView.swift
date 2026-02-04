//
//  PaymentSuccessView.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import SwiftUI

struct PaymentSuccessView: View {
    @Environment(NavigationRouter.self) private var router
    @Environment(ServicesAssembly.self) private var services
    @State private var isClosing = false

    private enum Constants {
        static let successText = "Успех! Оплата прошла,\nпоздравляем с покупкой!"
        static let buttonText = "Вернуться в корзину"
    }
    
    private enum Layout {
        static let imageSize: CGFloat = 278
        static let imageTopPadding: CGFloat = 150
        static let textTopPadding: CGFloat = 20
        static let buttonWidth: CGFloat = 343
        static let buttonHeight: CGFloat = 60
        static let buttonBottomPadding: CGFloat = 34
    }
    
    private func closeAndRefresh() {
        guard !isClosing else { return }
        isClosing = true
        Task { @MainActor in
            defer { isClosing = false }
            let order = try? await services.basketService.loadOrder()
            let profile = try? await services.nftService.fetchProfile()
            try? await services.basketService.clear()
            try? await services.nftService.loadBasket()
            if let profile, let order, !order.nfts.isEmpty {
                let mergedNfts = profile.nfts + order.nfts
                let uniqueNfts = Array(Set(mergedNfts))
                try? await services.nftService.updateProfileNfts(profile: profile, nfts: uniqueNfts)
            }
            _ = try? await services.nftService.fetchProfile()
            router.popToRoot()
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: Layout.imageTopPadding)
            
            Image(.paymentSuccess)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Layout.imageSize, height: Layout.imageSize)
                .clipped()
            
            Text(Constants.successText)
                .font(.title1Bold)
                .foregroundColor(.ypBlack)
                .multilineTextAlignment(.center)
                .padding(.top, Layout.textTopPadding)
            
            Spacer()
            
            Button(action: closeAndRefresh) {
                Group {
                    if isClosing {
                        ProgressView()
                            .tint(.ypWhite)
                    } else {
                        Text(Constants.buttonText)
                    }
                }
                .font(.title3Bold)
                .foregroundColor(.ypWhite)
                .frame(width: Layout.buttonWidth, height: Layout.buttonHeight)
                .background(Color.ypBlack)
                .cornerRadius(16)
            }
            .disabled(isClosing)
            .padding(.bottom, Layout.buttonBottomPadding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .task {
            let order = try? await services.basketService.loadOrder()
            let profile = try? await services.nftService.fetchProfile()
            try? await services.basketService.clear()
            try? await services.nftService.loadBasket()
            if let profile, let order, !order.nfts.isEmpty {
                let mergedNfts = profile.nfts + order.nfts
                let uniqueNfts = Array(Set(mergedNfts))
                try? await services.nftService.updateProfileNfts(profile: profile, nfts: uniqueNfts)
            }
            _ = try? await services.nftService.fetchProfile()
        }
    }
}

#Preview {
    NavigationStack {
        PaymentSuccessView()
    }
    .environment(NavigationRouter())
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
