//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct MyNFTView: View {
    private enum Constants {
        static let emptyNFTText = "У Вас еще нет NFT"
        static let myNFTs = "Мои NFT"
        static let sort = "Сортировка"
        static let close = "Закрыть"
        static let byPrice = "По цене"
        static let byRating = "По рейтингу"
        static let byName = "По названию"
    }
    @Environment(NavigationRouter.self) var router
    @Environment(ServicesAssembly.self) private var servicesAssembly
    
    private var viewModel: MyNFTViewModel
    @State private var profile: ProfileDTO
    @State private var showSortDialog = false
    
    init(profile: ProfileDTO) {
        self._profile = State(wrappedValue: profile)
        viewModel = MyNFTViewModel(ids: profile.nfts, likedIds: profile.likes)
    }
    
    var body: some View {
        ZStack {
            Text(Constants.emptyNFTText)
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
            List(viewModel.sortedCells) { nft in
                let cellViewModel = MyNFTCellViewModel(
                    model: nft,
                    ids: viewModel.ids,
                    likedIds: viewModel.likedIds,
                    mainViewModel: viewModel,
                    servicesAssembly: servicesAssembly
                )
                MyNFTCellView(cellViewModel: cellViewModel)
                    .listRowSeparator(.hidden)
                    .padding(.trailing, 30)
            }
            .listStyle(.plain)
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
                Text(Constants.myNFTs)
                    .font(.title3Bold)
                    .foregroundStyle(.ypBlack)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSortDialog = true
                } label: {
                    Image(.icSort)
                        .foregroundStyle(.ypBlack)
                }
                .confirmationDialog(
                    Constants.sort,
                    isPresented: $showSortDialog,
                    titleVisibility: .visible) {
                        Button(Constants.byPrice) {
                            viewModel.sortType = .byPrice
                        }
                        Button(Constants.byRating) {
                            viewModel.sortType = .byRating
                        }
                        Button(Constants.byName) {
                            viewModel.sortType = .byName
                        }
                        Button(Constants.close, role: .cancel) {}
                    }
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
    MyNFTView(profile: profile)
        .environment(router)
}
