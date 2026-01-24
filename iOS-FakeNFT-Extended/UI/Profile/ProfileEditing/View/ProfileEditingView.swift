//
//  ProfileEditingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 19.01.2026.
//

import SwiftUI

struct ProfileEditingView: View {
    @Environment(NavigationRouter.self) var router
    @State var profileViewModel: ProfileViewModel
    @State var viewModel: ProfileEditingViewModel
    
    init(viewModel: ProfileViewModel) {
        self.profileViewModel = viewModel
        self.viewModel = ProfileEditingViewModel(viewModel: viewModel)
    }
    
    var body: some View {
        VStack {
            backButton
            
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
    }
    
    private func isSomethingChanged() -> Bool {
        if profileViewModel.model.photo != URL(string: viewModel.model.imageURLText) {
            return true
        }
        if profileViewModel.model.name != viewModel.model.name {
            return true
        }
        if profileViewModel.model.description != viewModel.model.description {
            return true
        }
        if profileViewModel.model.website != URL(string: viewModel.model.website) {
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, -5)
        .padding(.top, 11)
    }
    
    private var avatarSection: some View {
        ZStack {
            ProfileAvatarView(imageURL: URL(string: viewModel.model.imageURLText))
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
            }
            Button("Отмена", role: .cancel) {}
        }
        .alert("Ссылка на фото", isPresented: $viewModel.model.showEditAlert) {
            TextField("Вставьте ссылку", text: $viewModel.model.imageURLText)
            
            Button("Сохранить") {
                profileViewModel.model.photo = URL(string: viewModel.model.imageURLText) ?? nil
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
            TextEditor(text: $viewModel.model.description)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .scrollContentBackground(.hidden)
                .background(Color.ypLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(maxHeight: 90)
                .padding(.bottom, 24)
            
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
            print("Pressed")
            
            profileViewModel.model.name = viewModel.model.name
            router.pop()
            
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
    let viewModel = ProfileViewModel()
    ProfileEditingView(viewModel: viewModel)
        .environment(router)
}
