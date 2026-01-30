//
//  CatalogView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import SwiftUI

struct CatalogView: View {
    private enum Constants {
        static let sortAlertTitle = "Сортировка"
        static let nameSortTitle = "По названию"
        static let countSortTitle = "По количеству NFT"
        static let cancelSortButtonTitle = "Закрыть"
    }
    
    @Environment(ServicesAssembly.self) private var servicesAssembly
    @Environment(NavigationRouter.self) private var router
    @State private var showSortSheet = false
    @State private var viewModel: CatalogViewModel
    
    init() {
        let initialState = CatalogViewModel()
        self._viewModel = State(wrappedValue: initialState)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button {
                        showSortSheet = true
                    } label: {
                        Image(.icSort)
                            .renderingMode(.original)
                    }
                    .opacity(viewModel.canChangeSort ? 1 : 0.4)
                    .disabled(!viewModel.canChangeSort)
                    .sortDialog(
                        isPresented: $showSortSheet,
                        dialog: SortConfirmationDialog(
                            title: Constants.sortAlertTitle,
                            options: [
                                SortOption(
                                    title: Constants.nameSortTitle,
                                    action: {
                                        sortByName()
                                    }
                                ),
                                SortOption(
                                    title: Constants.countSortTitle,
                                    action: {
                                        sortByCount()
                                    }
                                )
                            ]
                        ),
                        cancelButtonTitle: Constants.cancelSortButtonTitle
                    )
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
                            router.push(.catalogDetails(nftCollection: collection))
                        }
                }
                .listStyle(.plain)
                .listRowBackground(Color.clear)
                .refreshable {
                    if !viewModel.isLoading {
                        await viewModel.loadNFTCollections()
                    }
                }
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
            viewModel.setup(servicesAssembly: servicesAssembly)

            if viewModel.nftCollections.isEmpty {
                await viewModel.loadNFTCollections()
            }
        }

    }
}

private extension CatalogView {
    func sortByName() {
        Task {
            await viewModel.applySort(.name)
        }
    }
    
    func sortByCount() {
        Task {
            await viewModel.applySort(.nfts)
        }
    }
}

#Preview {
    CatalogView()
}
