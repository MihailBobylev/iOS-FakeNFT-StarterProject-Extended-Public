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
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image("ic_back")
                        .foregroundStyle(.ypBlack)
                }
                Spacer()
            }
            .padding(.horizontal, 9)
            .padding(.top, 11)
            Spacer()
            Text("Favorite NFT")
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let router = NavigationRouter()
    FavoriteNFTView()
        .environment(router)
}
