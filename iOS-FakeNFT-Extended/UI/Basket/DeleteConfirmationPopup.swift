//
//  DeleteConfirmationPopup.swift
//  NFT Market
//
//  Created by Dmitry on 25.01.2026.
//

import SwiftUI

struct DeleteConfirmationPopup: View {
    let nft: Nft
    let onDelete: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            // Размытый фон на весь экран (включая верх и низ, navigation bar и tab bar)
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Color.black.opacity(0.4)
                }
                .ignoresSafeArea(.all, edges: .all)
            
            // Попап без фона - контент плавает на размытом фоне
            VStack(spacing: 0) {
                VStack(spacing: 12) {
                    // Изображение NFT
                    Group {
                        if let imageName = getImageName(for: nft.name) {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else if let url = nft.images.first {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure:
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 108, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Текст подтверждения
                    Text("Вы уверены, что хотите\nудалить объект из корзины?")
                        .font(.footnoteRegular13)
                        .foregroundColor(.ypBlack)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                
                // Кнопки горизонтально: слева "Удалить", справа "Вернуться"
                HStack(spacing: 8) {
                    // Кнопка "Удалить" слева - черный прямоугольник с красным текстом
                    Button(action: onDelete) {
                        Text("Удалить")
                            .font(.footnoteRegular13)
                            .foregroundColor(.ypRed)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                    
                    // Кнопка "Вернуться" справа - черный прямоугольник с белым текстом
                    Button(action: onCancel) {
                        Text("Вернуться")
                            .font(.footnoteRegular13)
                            .foregroundColor(.ypWhite)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func getImageName(for nftName: String) -> String? {
        switch nftName {
        case "April":
            return "nft_april"
        case "Greena":
            return "nft_greena"
        case "Spring":
            return "nft_spring"
        default:
            return nil
        }
    }
}

#Preview {
    DeleteConfirmationPopup(
        nft: Nft(
            id: "1",
            name: "April",
            images: [],
            rating: 5,
            description: "Test",
            price: 1.78,
            author: "Test",
            website: URL(string: "https://example.com")!,
            createdAt: Date()
        ),
        onDelete: {},
        onCancel: {}
    )
}
