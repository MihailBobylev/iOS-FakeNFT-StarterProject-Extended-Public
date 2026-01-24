//
//  MyNFTView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct MyNFTView: View {
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image("ic_back")
                        .foregroundStyle(.ypBlack)
                }
                Spacer()
            }
            .padding(.horizontal, 9)
            .padding(.top, 11)
            Spacer()
            Text("My NFT")
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let router = NavigationRouter()
    MyNFTView()
        .environment(router)
}
