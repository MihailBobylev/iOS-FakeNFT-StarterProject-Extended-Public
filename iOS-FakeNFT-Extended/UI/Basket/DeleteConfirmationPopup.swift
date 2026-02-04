//
//  DeleteConfirmationPopup.swift
//  NFT Market
//
//  Created by Dmitry on 25.01.2026.
//

import Kingfisher
import SwiftUI

struct DeleteConfirmationPopup: View {
    let nft: Nft
    let onDelete: () -> Void
    let onCancel: () -> Void
    
    private enum Constants {
        static let confirmationText = "Вы уверены, что хотите\nудалить объект из корзины?"
        static let deleteButtonText = "Удалить"
        static let cancelButtonText = "Вернуться"
    }
    
    private static func assetName(for nftName: String) -> String? {
        switch nftName {
        case "April": return "nft_april"
        case "Greena": return "nft_greena"
        case "Spring": return "nft_spring"
        default: return nil
        }
    }
    
    @ViewBuilder
    private var nftImageView: some View {
        if let url = nft.images.first {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: Layout.nftImageSize, height: Layout.nftImageSize)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            imagePlaceholder
        }
    }
    
    @ViewBuilder
    private var imagePlaceholder: some View {
        if let name = Self.assetName(for: nft.name) {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image(systemName: "photo")
                .foregroundColor(.gray)
        }
    }
    
    private enum Layout {
        static let popupTopPadding: CGFloat = 190
        static let buttonWidth: CGFloat = 127
        static let captionLineSpacing: CGFloat = 5 // line height 18pt (18 - 13)
        static let nftImageSize: CGFloat = 108
        static let nftImageCornerRadius: CGFloat = 12
        static let nftImageTopOffset: CGFloat = 5
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Размытый фон на весь экран (включая верх и низ, navigation bar и tab bar)
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Color.ypWhite.opacity(0.2)
                }
                .ignoresSafeArea(.all, edges: .all)
            
            // Попап без фона - контент плавает на размытом фоне
            VStack(spacing: 0) {
                VStack(spacing: 12) {
                    nftImageView
                        .frame(width: Layout.nftImageSize, height: Layout.nftImageSize)
                        .clipShape(RoundedRectangle(cornerRadius: Layout.nftImageCornerRadius))
                        .offset(y: -Layout.nftImageTopOffset)
                    
                    Text(Constants.confirmationText)
                        .font(.footnoteRegular13)
                        .foregroundColor(.ypBlack)
                        .multilineTextAlignment(.center)
                        .lineSpacing(Layout.captionLineSpacing)
                }
                .padding(.top, 20)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                
                HStack(spacing: 8) {
                    Button(action: onDelete) {
                        Text(Constants.deleteButtonText)
                            .font(.bodyRegular)
                            .foregroundColor(.ypRed)
                            .frame(width: Layout.buttonWidth, height: 44)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                    
                    Button(action: onCancel) {
                        Text(Constants.cancelButtonText)
                            .font(.bodyRegular)
                            .foregroundColor(.ypWhite)
                            .frame(width: Layout.buttonWidth, height: 44)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 16)
            .padding(.top, Layout.popupTopPadding)
        }
    }
}

#Preview {
    if let nft = Nft.mocks.first {
        DeleteConfirmationPopup(
            nft: nft,
            onDelete: {},
            onCancel: {}
        )
    }
}
