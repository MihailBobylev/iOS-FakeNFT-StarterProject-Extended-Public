//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 16.01.2026.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var viewModel: ProfileViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URL(string: viewModel.profile.website ?? "")!))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ProfileView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(ServicesAssembly.self) private var servicesAssembly
    @State var viewModel: ProfileViewModel
    @State private var showWebView = false
    private let profileStorage: ProfileStorage
    
    init() {
        let viewModel = ProfileViewModel()
        self._viewModel = State(wrappedValue: viewModel)
        profileStorage = ProfileStorage()
    }
    
    var body: some View {
        VStack {
            if !viewModel.isLoading {
                HStack {
                    Spacer()
                    Button {
                        router.push(AppRoute.profileEditing(profile: viewModel.profile))
                    } label: {
                        Image(.icEdit)
                            .foregroundStyle(.ypBlack)
                    }
                }
                
                HStack {
                    ProfileAvatarView(imageURL: URL(string: viewModel.profile.avatar ?? ""))
                    Text(viewModel.profile.name ?? "")
                        .font(.title1Bold)
                        .foregroundStyle(.ypBlack)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 16)
                
                Text(viewModel.profile.description ?? "")
                    .font(.footnoteRegular13)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                NavigationLink("\(viewModel.profile.name ?? "").com") {
                    WebView(viewModel: viewModel)
                }
                .font(.footnoteRegular15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                
                Button {
                    router.push(AppRoute.myNFT)
                } label: {
                    ProfileListView(title: "Мои NFT (\(viewModel.profile.nfts.count))")
                }
                .padding(.top, 58)
                
                Button {
                    router.push(AppRoute.favoriteNFT(profile: viewModel.profile))
                } label: {
                    ProfileListView(title: "Избранные NFT (\(viewModel.profile.likes.count))")
                }
                .padding(.top, 26)
                
                Spacer()
            } else {
                ProgressView()
            }
        }
        .padding(.horizontal, 16)
        .task {
            viewModel.configure(servicesAssembly: servicesAssembly)
            await viewModel.loadProfile()
        }
    }
}

#Preview {
    let router = NavigationRouter()
    let servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        profileStorage: ProfileStorage()
    )
    
    ProfileView()
        .environment(router)
        .environment(servicesAssembly)
}
