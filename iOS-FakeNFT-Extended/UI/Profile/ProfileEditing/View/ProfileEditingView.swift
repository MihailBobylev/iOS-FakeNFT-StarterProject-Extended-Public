//
//  ProfileEditingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 19.01.2026.
//

import SwiftUI

struct ProfileEditingView: View {
    @Environment(NavigationRouter.self) private var router
    @Environment(ServicesAssembly.self) private var servicesAssembly
    @State private var viewModel: ProfileEditingViewModel
    @State private var profile: ProfileDTO
    @State private var isLoading = false
    @State private var newImageUrl: String = ""
    
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
            Image("ic_back")
                .foregroundStyle(.ypBlack)
        }
        .alert("Уверены, что хотите выйти?", isPresented: $viewModel.model.showBackAlert) {
            Button("Остаться") {}
            
            Button("Выйти", role: .cancel) {
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
            "Фото профиля",
            isPresented: $viewModel.model.showPhotoActions,
            titleVisibility: .visible
        ) {
            Button("Изменить фото") {
                viewModel.model.showEditAlert = true
            }
            Button("Удалить фото", role: .destructive) {
                viewModel.model.imageURLText = ""
                newImageUrl = ""
            }
            Button("Отмена", role: .cancel) {}
        }
        .alert("Ссылка на фото", isPresented: $viewModel.model.showEditAlert) {
            TextField("Вставьте ссылку", text: $newImageUrl)
            
            Button("Сохранить") {
                if newImageUrl != viewModel.model.imageURLText {
                    viewModel.model.imageURLText = newImageUrl
                }
            }
            
            Button("Отмена", role: .cancel) {}
        }
    }
    
    private var formSection: some View {
        VStack {
            Text("Имя")
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField("Введите имя", text: $viewModel.model.name)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 44)
                        .foregroundStyle(.ypLightGray)
                )
                .padding(.bottom, 24)
            
            Text("Описание")
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            MultilineTextFieldView(
                text: $viewModel.model.description,
                placeholder: "Введите описание"
            )
            
            Text("Сайт")
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField("Введите сайт", text: $viewModel.model.website)
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
            Image("ic_photo")
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
                        website: viewModel.model.website
                    )
                    isLoading = true
                    try await servicesAssembly.nftService.putProfile(with: newProfile)
                    profile = newProfile
                    print("Data Updated")
                    router.pop()
                } catch {
                    print("Error")
                }
            }
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: 60)
                    .foregroundStyle(.ypBlack)
                Text("Сохранить")
                    .font(.title3Bold)
                    .foregroundStyle(.ypWhite)
            }
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
        profileStorage: ProfileStorage()
    )
    ProfileEditingView(
            profile: ProfileDTO(
            id: "id",
            name: "Ivan Petrov",
            avatar: nil,
            description: "Описание",
            website: nil
        )
    )
        .environment(router)
        .environment(servicesAssembly)
}
