//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import SwiftUI

enum Route: Hashable {
    case myNFT
    case favoriteNFT
}

struct ProfileView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Button {
                    path.append(Route.myNFT)
                } label: {
                    ProfileListView(title: "Мои NFT")
                }
                .listRowSeparator(.hidden)
                
                Button {
                    path.append(Route.favoriteNFT)
                } label: {
                    ProfileListView(title: "Избранные NFT")
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .myNFT:
                    MyNFTView()
                case .favoriteNFT:
                    FavoriteNFTView()
                }
            }
        }
        
    }
}

#Preview {
    ProfileView()
}
