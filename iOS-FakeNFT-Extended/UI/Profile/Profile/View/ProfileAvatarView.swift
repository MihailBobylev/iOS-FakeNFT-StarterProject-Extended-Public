//
//  PhotoView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 20.01.2026.
//

import SwiftUI

struct ProfileAvatarView: View {
    let imageURL: URL?
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                placeholder
            case .success(let image):
                ZStack {
                    ProgressView()
                        .frame(width: 70, height: 70)
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }
            case .failure:
                ZStack {
                    placeholder
                    ProgressView()
                        .frame(width: 70, height: 70)
                }
            @unknown default:
                placeholder
            }
        }

    }
    
    private var placeholder: some View {
        Image("ic_user")
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
    }
}

#Preview {
    ProfileAvatarView(
        imageURL: URL(
            string: "https://s0.rbk.ru/v6_top_pics/media/img/3/50/347328733549503.jpeg"
        )
    )
}
