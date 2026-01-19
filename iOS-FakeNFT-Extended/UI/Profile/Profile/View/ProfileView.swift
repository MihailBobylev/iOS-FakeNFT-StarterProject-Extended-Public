//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import SwiftUI

struct ProfileView: View {
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    router.push(AppRoute.editProfile)
                } label: {
                    Image("ic_edit")
                        .foregroundStyle(.ypBlack)
                }
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            VStack {
                Button {
                    router.push(AppRoute.myNFT)
                } label: {
                    ProfileListView(title: "Мои NFT")
                }
                .padding(.vertical, 10)
                
                Button {
                    router.push(AppRoute.favoriteNFT)
                } label: {
                    ProfileListView(title: "Избранные NFT")
                }
                .padding(.vertical, 10)
            }
            .padding(.horizontal, 16)
                
            Spacer()
        }
    }
}

#Preview {
    let router = NavigationRouter()
    ProfileView()
        .environment(router)
}
