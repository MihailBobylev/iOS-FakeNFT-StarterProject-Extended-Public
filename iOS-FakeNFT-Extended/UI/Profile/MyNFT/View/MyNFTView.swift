//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct MyNFTView: View {
    @Environment(NavigationRouter.self) var router
    
    @State private var viewModel: MyNFTViewModel
    @State private var showSortDialog = false
    init() {
        viewModel = MyNFTViewModel()
    }
    
    var body: some View {
        VStack {
            List(viewModel.cellViewModels) { cellViewModel in
                MyNFTCellView(viewModel: cellViewModel)
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
                    Image("ic_back")
                        .foregroundStyle(.ypBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Мои NFT")
                    .font(.title3Bold)
                    .foregroundStyle(.ypBlack)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Настройки")
                    showSortDialog = true
                } label: {
                    Image("ic_sort")
                        .foregroundStyle(.ypBlack)
                }
                .confirmationDialog(
                    "Сортировка",
                    isPresented: $showSortDialog,
                    titleVisibility: .visible) {
                        Button("По цене") {
                            print("First")
                            viewModel.sortType = .byPrice
                        }
                        Button("По рейтингу") {
                            print("Second")
                            viewModel.sortType = .byRating
                        }
                        Button("По названию") {
                            print("Third")
                            viewModel.sortType = .byName
                        }
                        Button("Закрыть", role: .cancel) {}
                    }
            }
            
        }
    }
}

#Preview {
    let router = NavigationRouter()
    MyNFTView()
        .environment(router)
}
