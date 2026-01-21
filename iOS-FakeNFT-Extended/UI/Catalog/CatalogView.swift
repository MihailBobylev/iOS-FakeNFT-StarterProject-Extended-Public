//
//  CatalogView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import SwiftUI

struct CatalogView: View {
    @State private var viewModel: CatalogViewModel
    
    init(servicesAssembly: ServicesAssembly) {
        let initialState = CatalogViewModel(servicesAssembly: servicesAssembly)
        self._viewModel = State(wrappedValue: initialState)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button {
                        // TODO: - Открыть алерт сортировки
                    } label: {
                        Image(.icSort)
                            .renderingMode(.original)
                    }
                }
                .padding(.horizontal, 9)
                List(viewModel.nftCollections, id: \.id) { collection in
                    CatalogItemRowView(model: collection)
                        .listRowInsets(.init(top: 0, leading: 16, bottom: 21, trailing: 16))
                        .listRowSeparator(.hidden)
                        .frame(maxHeight: 166)
                        .task {
                            await viewModel.loadNextPageIfNeeded(currentItem: collection)
                        }
                        .onTapGesture {
                            // TODO: - Переход на экран деталей
                        }
                }
                .listStyle(.plain)
                .listRowBackground(Color.clear)
            }
            
            ProgressView()
                .opacity(viewModel.isLoading ? 1 : 0)
            
            VStack {
                Spacer()
                ProgressView()
                    .padding(.bottom, 16)
            }
            .opacity(viewModel.isPageLoading ? 1 : 0)
            
            if let error = viewModel.requestError {
                Text(error.title)
                    .foregroundStyle(.red)
                    .padding()
            }
        }
        .task {
            if viewModel.nftCollections.isEmpty {
                await viewModel.loadNFTCollections()
            }
        }
    }
}

#Preview {
    CatalogView(
        servicesAssembly: ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl(),
            nftCollectionStorage: NFTCollectionStorage()
        )
    )
}
