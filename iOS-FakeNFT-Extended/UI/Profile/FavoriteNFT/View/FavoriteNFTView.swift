//
//  FavoriteNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct FavoriteNFTView: View {
    @Environment(NavigationRouter.self) var router
    
    @State private var viewModel: FavoriteNFTViewModel
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    init() {
        viewModel = FavoriteNFTViewModel()
    }
    
    var body: some View {
        VStack {
            if viewModel.cellViewModels.isEmpty {
                Text("У Вас еще нет избранных NFT")
                    .font(.title3Bold)
                    .foregroundStyle(.ypBlack)
            }
            else {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.cellViewModels) { cellViewModel in
                            FavoriteNFTCellView(viewModel: cellViewModel)
                                .padding(.trailing, 10)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
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
                Text("Избранные NFT")
                    .font(.title3Bold)
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    let router = NavigationRouter()
    FavoriteNFTView()
        .environment(router)
}
