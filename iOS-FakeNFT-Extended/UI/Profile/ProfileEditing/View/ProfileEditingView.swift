//
//  ProfileEditingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 19.01.2026.
//

import SwiftUI

struct ProfileEditingView: View {
    enum Constants {
        static let save = "Сохранить"
        static let error = "Ошибка"
        static let wantToExit = "Уверены, что хотите выйти?"
        static let stay = "Остаться"
        static let exit = "Выйти"
        static let profilePhoto = "Фото профиля"
        static let changePhoto = "Изменить фото"
        static let deletePhoto = "Удалить фото"
        static let cancel = "Отмена"
        static let photoURL = "Ссылка на фото"
        static let enterURL = "Вставьте ссылку"
        static let name = "Имя"
        static let enterName = "Введите имя"
        static let description = "Описание"
        static let enterDescription = "Введите описание"
        static let website = "Сайт"
        static let enterWebsite = "Введите сайт"
        static let OK = "OK"
    }
    
    @Environment(NavigationRouter.self) private var router
    @Environment(ServicesAssembly.self) private var servicesAssembly
    @State private var viewModel: ProfileEditingViewModel
    @State private var profile: ProfileDTO
    @State private var isLoading = false
    @State private var newImageUrl: String = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = "Ошибка при сохранении"
    
    init(profile: ProfileDTO) {
        self._profile = State(wrappedValue: profile)
        let state = ProfileEditingViewModel(profile: profile)
        self._viewModel = State(wrappedValue: state)
        self._newImageUrl = State(wrappedValue: profile.avatar ?? "")
    }
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            VStack {
                ScrollView {
                    avatarSection
                    formSection
                }
                .scrollIndicators(.hidden)
                
                if isSomethingChanged() {
                    saveButton
                }
            }
            .padding(.horizontal, 16)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }
    
    private func isSomethingChanged() -> Bool {
        if profile.avatar != viewModel.model.imageURLText {
            return true
        }
        if profile.name != viewModel.model.name {
            return true
        }
        if (profile.description ?? "") != viewModel.model.description {
            return true
        }
        if profile.website != viewModel.model.website {
            return true
        }
        return false
    }
}

extension ProfileEditingView {
    
    private var backButton: some View {
        Button {
            viewModel.model.showBackAlert = true
        } label: {
            Image(.icBack)
                .foregroundStyle(.ypBlack)
        }
        .alert(Constants.wantToExit, isPresented: $viewModel.model.showBackAlert) {
            Button(Constants.stay) {}
            
            Button(Constants.exit, role: .cancel) {
                router.pop()
            }
        }
    }
    
    private var avatarSection: some View {
        ZStack {
            ProfileAvatarView(imageURL: URL(string: newImageUrl))
            editButton
        }
        .confirmationDialog(
            Constants.profilePhoto,
            isPresented: $viewModel.model.showPhotoActions,
            titleVisibility: .visible
        ) {
            Button(Constants.changePhoto) {
                viewModel.model.showEditAlert = true
            }
            Button(Constants.deletePhoto, role: .destructive) {
                viewModel.model.imageURLText = ""
                newImageUrl = ""
            }
            Button(Constants.cancel, role: .cancel) {}
        }
        .alert(Constants.photoURL, isPresented: $viewModel.model.showEditAlert) {
            TextField(Constants.enterURL, text: $newImageUrl)
            
            Button(Constants.save) {
                if newImageUrl != viewModel.model.imageURLText {
                    viewModel.model.imageURLText = newImageUrl
                }
            }
            
            Button(Constants.cancel, role: .cancel) {}
        }
    }
    
    private var formSection: some View {
        VStack {
            Text(Constants.name)
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField(Constants.enterName, text: $viewModel.model.name)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 44)
                        .foregroundStyle(.ypLightGray)
                )
                .padding(.bottom, 24)
            
            Text(Constants.description)
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            ProfileEditorTextFieldView(
                text: $viewModel.model.description,
                placeholder: Constants.enterDescription
            )
            
            Text(Constants.website)
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField(Constants.enterWebsite, text: $viewModel.model.website)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .padding(.horizontal, 16)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 44)
                        .foregroundStyle(.ypLightGray)
                )
        }
    }
    
    private var editButton: some View {
        Button {
            viewModel.model.showPhotoActions = true
        } label: {
            Image(.icPhoto)
                .foregroundStyle(.ypBlack)
                .frame(width: 23, height: 23)
                .background(Color.ypLightGray)
                .clipShape(Circle())
        }
        .offset(x: 25, y: 25)
    }
    
    private var saveButton: some View {
        Button {
            Task {
                do {
                    let newProfile = ProfileDTO(
                        id: profile.id,
                        name: viewModel.model.name,
                        avatar: viewModel.model.imageURLText,
                        description: viewModel.model.description,
                        website: viewModel.model.website,
                        nfts: profile.nfts,
                        likes: profile.likes
                    )
                    isLoading = true
                    try await servicesAssembly.nftService.updateProfile(with: newProfile)
                    profile = newProfile
                    router.pop()
                } catch {
                    showErrorAlert = true
                }
            }
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: 60)
                    .foregroundStyle(.ypBlack)
                Text(Constants.save)
                    .font(.title3Bold)
                    .foregroundStyle(.ypWhite)
            }
        }
        .alert(Constants.error,
               isPresented: $showErrorAlert) {
            Button(Constants.OK, role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        .padding(.bottom, 16)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    let router = NavigationRouter()
    let servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        profileStorage: ProfileStorage(),
        nftCollectionStorage: NFTCollectionStorage(),
        nftFavoriteStorage: NFTFavoriteStorage(),
        nftBasketStorage: NFTBasketStorage()
    )
    ProfileEditingView(
            profile: ProfileDTO(
            id: "id",
            name: "Ivan Petrov",
            avatar: nil,
            description: "Описание",
            website: nil,
            nfts: [],
            likes: [
                "cc74e9ab-2189-465f-a1a6-8405e07e9fe4",
                "a06d0075-d1a7-40dc-b710-db6808c28cca"
            ]
        )
    )
        .environment(router)
        .environment(servicesAssembly)
}
