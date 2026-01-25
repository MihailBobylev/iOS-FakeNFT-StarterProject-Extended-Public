//
//  FavoriteNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct FavoriteNFTView: View {
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        VStack {
            Spacer()
            Text("Favorite NFT")
            Spacer()
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
