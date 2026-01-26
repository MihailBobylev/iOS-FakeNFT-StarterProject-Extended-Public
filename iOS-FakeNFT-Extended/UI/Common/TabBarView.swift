import SwiftUI

struct TabBarView: View {
    @Environment(NavigationRouter.self) private var router
    
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
        .overlay {
            if let deleteItem = router.deleteConfirmationItem {
                DeleteConfirmationPopup(
                    nft: deleteItem.nft,
                    onDelete: {
                        deleteItem.onDelete()
                    },
                    onCancel: {
                        router.hideDeleteConfirmation()
                    }
                )
                .zIndex(1000)
            }
            
            if let sortItem = router.sortPopupItem {
                SortPopup(
                    currentSort: sortItem.currentSort,
                    onSelect: { option in
                        sortItem.onSelect(option)
                        router.hideSortPopup()
                    },
                    onClose: {
                        router.hideSortPopup()
                    }
                )
                .zIndex(1001)
            }
        }
    }
}
