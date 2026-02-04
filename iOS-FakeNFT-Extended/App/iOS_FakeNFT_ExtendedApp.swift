import SwiftUI

@main
struct iOS_FakeNFT_ExtendedApp: App {
    @State private var router = NavigationRouter()
    @State private var servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        profileStorage: ProfileStorage(),
        nftCollectionStorage: NFTCollectionStorage(),
        nftFavoriteStorage: NFTFavoriteStorage(),
        nftBasketStorage: NFTBasketStorage()
    )
    
    init() {
        setupTabBar()
    }
    
    var body: some Scene {
        @Bindable var navigationRouter = router
        
        WindowGroup {
            NavigationStack(path: $navigationRouter.path) {
                ContentView()
                    .navigationDestination(for: AppRoute.self) { route in
                        router.destination(
                            for: route
                        )
                    }
            }
            .environment(router)
            .environment(servicesAssembly)
        }
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .clear
        
        // MARK: - Обычный стиль табов
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.ypBlack
        ]
        
        // MARK: - Стиль выбранных табов
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.ypBlue
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
