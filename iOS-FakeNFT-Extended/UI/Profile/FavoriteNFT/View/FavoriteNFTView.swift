//
//  FavoriteNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct FavoriteNFTView: View {
    private enum Constants {
        static let emptyNFTText = "У Вас еще нет избранных NFT"
        static let favoritesNFT = "Избранные NFT"
    }
    
    @Environment(NavigationRouter.self) var router
    @Environment(ServicesAssembly.self) private var servicesAssembly
    
    private var viewModel: FavoriteNFTViewModel
    @State private var profile: ProfileDTO
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    init(profile: ProfileDTO) {
        self._profile = State(wrappedValue: profile)
        viewModel = FavoriteNFTViewModel(ids: profile.likes)
    }
    
    var body: some View {
        ZStack {
            Text(Constants.emptyNFTText)
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
                .opacity(viewModel.nfts.isEmpty ? 1.0 : 0)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.nfts) { nft in
                        let cellViewModel = FavoriteNFTCellViewModel(
                            model: nft,
                            with: viewModel.ids,
                            mainViewModel: viewModel,
                            servicesAssembly: servicesAssembly
                        )
                        FavoriteNFTCellView(cellViewModel: cellViewModel)
                            .padding(.trailing, 10)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.pop()
                } label: {
                    Image(.icBack)
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(Constants.favoritesNFT)
                    .font(.title3Bold)
                    .foregroundStyle(.ypBlack)
            }
        }
        .task {
            viewModel.configure(servicesAssembly: servicesAssembly)
            await viewModel.loadNfts()
        }
    }
}

#Preview {
    let router = NavigationRouter()
    let profile = ProfileDTO(
        id: "",
        name: "",
        avatar: "",
        description: "",
        website: "",
        nfts: [],
        likes: []
    )
    FavoriteNFTView(profile: profile)
        .environment(router)
}
