//
//  ProfileEditingView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 19.01.2026.
//

import SwiftUI

struct ProfileEditingView: View {
    @Environment(NavigationRouter.self) var router
    @State private var isChanged: Bool = false
    @State private var showPhotoActions: Bool = false
    @State private var showEditAlert: Bool = false
    @State private var imageURLText: String = ""
    @State private var showSaveButton: Bool = false
    @State private var showBackAlert: Bool = false
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var website: String = ""
    
    let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        
        _name = State(initialValue: viewModel.model.name)
        _description = State(initialValue: viewModel.model.description)
        _website = State(initialValue: viewModel.model.website?.absoluteString ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showBackAlert = true
                } label: {
                    Image("ic_back")
                        .foregroundStyle(.ypBlack)
                }
                .alert("Уверены, что хотите выйти?", isPresented: $showBackAlert) {
                    Button("Остаться") {}
                    
                    Button("Выйти", role: .cancel) {
                        router.pop()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, -5)
            .padding(.top, 11)
            
            ZStack {
                ProfileAvatarView(imageURL: viewModel.model.photo)
                editButton
            }
            .confirmationDialog(
                "Фото профиля",
                isPresented: $showPhotoActions,
                titleVisibility: .visible
            ) {
                Button("Изменить фото") {
                    showEditAlert = true
                }
                Button("Удалить фото", role: .destructive) {
                    viewModel.model.photo = nil
                }
                Button("Отмена", role: .cancel) {}
            }
            .alert("Ссылка на фото", isPresented: $showEditAlert) {
                TextField("Вставьте ссылку", text: $imageURLText)
                
                Button("Сохранить") {
                    viewModel.model.photo = URL(string: imageURLText) ?? nil
                }
                
                Button("Отмена", role: .cancel) {}
            }
            
            Text("Имя")
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField("Введите имя", text: $name)
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
            TextEditor(text: $description)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .scrollContentBackground(.hidden)
                .background(Color.ypLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(maxHeight: 132)
                .padding(.bottom, 24)
            
            Text("Сайт")
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            TextField("Введите сайт", text: $website)
                .font(.title2Regular)
                .foregroundStyle(.ypBlack)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 44)
                        .foregroundStyle(.ypLightGray)
                )

            Spacer()
            
            if showSaveButton {
                Button {
                    print("Pressed")
                } label: {
                    Text("Сохранить")
                        .font(.title3Bold)
                        .foregroundStyle(.ypWhite)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 60)
                        .foregroundStyle(.ypBlack)
                )
                .padding(.bottom, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 16)
    }
    
    private var editButton: some View {
        Button {
            showPhotoActions = true
        } label: {
            Image("ic_photo")
                .foregroundStyle(.ypBlack)
                .frame(width: 23, height: 23)
                .background(Color.ypLightGray)
                .clipShape(Circle())
        }
        .offset(x: 25, y: 25)
    }
}

#Preview {
    let router = NavigationRouter()
    let viewModel = ProfileViewModel()
    ProfileEditingView(viewModel: viewModel)
        .environment(router)
}
