import SwiftUI

struct TabBarView: View {
    private enum Constants {
        static let profilePrompt = "Профиль"
        static let catalogPrompt = "Каталог"
        static let basketPrompt = "Корзина"
    }
    
    var body: some View {
        TabView {
            ProfileView()
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
