//
//  CatalogDetailsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 22.01.2026.
//

import SwiftUI

struct CatalogDetailsView: View {
    private enum Constants {
        static let author = "Автор коллекции:"
    }
    
    @Environment(ServicesAssembly.self) private var servicesAssembly
    @Environment(NavigationRouter.self) private var router
    @State private var viewModel: CatalogDetailsViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 9),
        GridItem(.flexible(), spacing: 9),
        GridItem(.flexible(), spacing: 9)
    ]
    
    init(nftCollection: NFTCollectionModel) {
        let initialState = CatalogDetailsViewModel(nftCollection: nftCollection)
        self._viewModel = State(wrappedValue: initialState)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    if let url = URL(string: viewModel.nftCollection.cover ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 310)
                                .clipped()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                                .frame(height: 310)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.nftCollection.name ?? "")
                            .font(.title1Bold)
                            .foregroundStyle(.ypBlack)
                            .padding(.bottom, 13)
                        
                        HStack(spacing: 4) {
                            Text(Constants.author)
                                .font(.footnoteRegular13)
                                .foregroundStyle(.ypBlack)
                            
                            Text(viewModel.nftCollection.author ?? "")
                                .font(.footnoteRegular15)
                                .foregroundStyle(.ypBlue)
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: viewModel.nftCollection.website) {
                                        router.push(
                                            .webView(
                                                url: url
                                            )
                                        )
                                    }
                                }
                        }
                        .padding(.bottom, 5)
                        
                        Text(viewModel.nftCollection.description ?? "")
                            .font(.footnoteRegular13)
                            .foregroundStyle(.ypBlack)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top], 16)
                    
                    if let error = viewModel.requestError {
                        Text(error.title)
                            .foregroundStyle(.red)
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: 29) {
                            ForEach(viewModel.nfts) {
                                NFTCatalogCell(
                                    model: $0,
                                    onFavoriteTap: { id in
                                        Task {
                                            await viewModel.toggleFavorite(with: id)
                                        }
                                    },
                                    onBasketTap: { id in
                                        Task {
                                            await viewModel.toggleBasket(with: id)
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                    }
                    
                    ProgressView()
                        .opacity(viewModel.isLoading ? 1 : 0)
                }
            }
            .scrollIndicators(.hidden)
            .edgesIgnoringSafeArea(.top)
            
            Button {
                router.pop()
            } label: {
                Image(.icBack)
                    .renderingMode(.original)
            }
            .padding([.top, .leading], 9)
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadNFTs()
        }
        .task {
            viewModel.setup(servicesAssembly: servicesAssembly)
            await viewModel.loadNFTs()
        }
    }
}

#Preview {
    CatalogDetailsView(
        nftCollection: .init(
            id: "d4fea6b6-91f1-45ce-9745-55431e69ef5c",
            name: "singulis epicuri",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Brown.png",
            nfts: [
                "c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
                "d6a02bd1-1255-46cd-815b-656174c1d9c0",
                "f380f245-0264-4b42-8e7e-c4486e237504"
            ],
            description: "curabitur feugait a definitiones singulis movet eros aeque mucius evertitur assueverit et eam",
            author: "Lourdes Harper"
        )
    )
}
