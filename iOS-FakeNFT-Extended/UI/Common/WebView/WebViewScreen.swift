//
//  WebViewScreen.swift
//  iOS-FakeNFT-Extended
//
//  Created by Михаил Бобылев on 29.01.2026.
//

import SwiftUI

struct WebViewScreen: View {
    @Environment(NavigationRouter.self) private var router
    
    let url: URL

    var body: some View {
        VStack {
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image(.icBack)
                        .renderingMode(.original)
                }
                .padding([.top, .leading], 9)
                
                Spacer()
            }
            
            WebView(url: url)
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}
