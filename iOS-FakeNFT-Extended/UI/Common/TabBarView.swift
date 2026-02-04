import SwiftUI

struct TabBarView: View {
    @Environment(NavigationRouter.self) private var router
    
    private enum Constants {
        static let profilePrompt = "Профиль"
        static let catalogPrompt = "Каталог"
        static let basketPrompt = "Корзина"
    }
    
    var body: some View {
        TabView(selection: Binding(
            get: { router.selectedTab },
            set: { router.selectedTab = $0 }
        )) {
            ProfileView()
                .tabItem {
                    Label(Constants.profilePrompt, image: .icProfile)
                }
                .tag(AppTab.profile)
            CatalogView()
                .tabItem {
                    Label(Constants.catalogPrompt, image: .icCatalog)
                }
                .tag(AppTab.catalog)
            BasketView()
                .tabItem {
                    Label(Constants.basketPrompt, image: .icBasket)
                }
                .tag(AppTab.basket)
        }
        .overlay {
            if let deleteItem = router.deleteConfirmationItem {
                DeleteConfirmationPopup(
                    item: deleteItem.item,
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

struct DeleteConfirmationPopup: View {
    let item: NFTCatalogCellModel
    let onDelete: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text("Удалить NFT из корзины?")
                    .font(.footnoteRegular13)
                    .multilineTextAlignment(.center)
                HStack(spacing: 12) {
                    Button(action: onDelete) {
                        Text("Удалить")
                            .font(.bodyRegular)
                            .foregroundColor(.ypRed)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                    Button(action: onCancel) {
                        Text("Отмена")
                            .font(.bodyRegular)
                            .foregroundColor(.ypWhite)
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                }
            }
            .padding(16)
            .background(Color.ypWhite)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
    }
}

struct SortPopup: View {
    let currentSort: BasketSortOption
    let onSelect: (BasketSortOption) -> Void
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            Color.ypModalOverlay
                .ignoresSafeArea()
                .onTapGesture { onClose() }
            
            VStack(spacing: 8) {
                Button("По цене") {
                    onSelect(.price)
                }
                Button("По рейтингу") {
                    onSelect(.rating)
                }
                Button("По названию") {
                    onSelect(.name)
                }
                Button("Закрыть") {
                    onClose()
                }
            }
            .font(.title3Regular)
            .foregroundColor(.ypBlue)
            .padding()
            .background(Color.ypWhite)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
    }
}
