//
//  PaymentSuccessView.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import SwiftUI

struct PaymentSuccessView: View {
    @Environment(NavigationRouter.self) private var router
    
    private enum Constants {
        static let successText = "Успех! Оплата прошла,\nпоздравляем с покупкой!"
        static let buttonText = "Вернуться в корзину"
    }
    
    private enum Layout {
        static let imageSize: CGFloat = 278
        static let imageTopPadding: CGFloat = 150
        static let textTopPadding: CGFloat = 20
        static let buttonWidth: CGFloat = 343
        static let buttonHeight: CGFloat = 60
        static let buttonBottomPadding: CGFloat = 34
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: Layout.imageTopPadding)
            
            Image("payment_success")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Layout.imageSize, height: Layout.imageSize)
                .clipped()
            
            Text(Constants.successText)
                .font(.title1Bold)
                .foregroundColor(.ypBlack)
                .multilineTextAlignment(.center)
                .padding(.top, Layout.textTopPadding)
            
            Spacer()
            
            Button(action: {
                router.path = NavigationPath()
            }) {
                Text(Constants.buttonText)
                    .font(.title3Bold)
                    .foregroundColor(.ypWhite)
                    .frame(width: Layout.buttonWidth, height: Layout.buttonHeight)
                    .background(Color.ypBlack)
                    .cornerRadius(16)
            }
            .padding(.bottom, Layout.buttonBottomPadding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        PaymentSuccessView()
    }
    .environment(NavigationRouter())
}
