//
//  DeleteConfirmationPopup.swift
//  iOS-FakeNFT-Extended
//
//  Created by Dmitry on 06.02.2026.
//

import Kingfisher
import SwiftUI

struct DeleteConfirmationPopup: View {
    let item: NFTCatalogCellModel
    let onDelete: () -> Void
    let onCancel: () -> Void
    
    private enum Constants {
        static let confirmationText = "Вы уверены, что хотите\nудалить объект из корзины?"
        static let deleteButtonText = "Удалить"
        static let cancelButtonText = "Вернуться"
    }
    
    private enum Layout {
        static let popupTopPadding: CGFloat = 190
        static let buttonWidth: CGFloat = 127
        static let captionLineSpacing: CGFloat = 5
        static let nftImageSize: CGFloat = 108
        static let nftImageCornerRadius: CGFloat = 12
        static let nftImageTopOffset: CGFloat = 5
        static let buttonHeight: CGFloat = 44
        static let buttonSpacing: CGFloat = 8
        static let contentSpacing: CGFloat = 12
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Color.ypWhite.opacity(0.2)
                }
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 0) {
                VStack(spacing: Layout.contentSpacing) {
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
                
                HStack(spacing: Layout.buttonSpacing) {
                    Button(action: onDelete) {
                        Text(Constants.deleteButtonText)
                            .font(.bodyRegular)
                            .foregroundColor(.ypRed)
                            .frame(width: Layout.buttonWidth, height: Layout.buttonHeight)
                            .background(Color.ypBlack)
                            .cornerRadius(12)
                    }
                    
                    Button(action: onCancel) {
                        Text(Constants.cancelButtonText)
                            .font(.bodyRegular)
                            .foregroundColor(.ypWhite)
                            .frame(width: Layout.buttonWidth, height: Layout.buttonHeight)
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
    
    @ViewBuilder
    private var nftImageView: some View {
        if let cover = item.cover, let url = URL(string: cover) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .frame(width: Layout.nftImageSize, height: Layout.nftImageSize)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else if let name = imageResource(for: item.name) {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image(systemName: "photo")
                .foregroundColor(.gray)
        }
    }
    
    private func imageResource(for nftName: String) -> String? {
        switch nftName {
        case "April": return "nft_april"
        case "Greena": return "nft_greena"
        case "Spring": return "nft_spring"
        default: return nil
        }
    }
}

