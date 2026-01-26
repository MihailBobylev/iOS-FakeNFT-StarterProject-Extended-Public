import SwiftUI

struct TabBarView: View {
    private enum Constants {
        static let profilePrompt = "Профиль"
        static let catalogPrompt = "Каталог"
        static let basketPrompt = "Корзина"
    }
    
    @Environment(ServicesAssembly.self) private var servicesAssembly
    
    var body: some View {
        TabView {
            ProfileView(servicesAssembly: servicesAssembly)
                .tabItem {
                    Label(Constants.profilePrompt, image: .icProfile)
                }
            CatalogView()
                .tabItem {
                    Label(Constants.catalogPrompt, image: .icCatalog)
                }
            BasketView()
                .tabItem {
                    Label(Constants.basketPrompt, image: .icBasket)
                }
        }
    }
}
