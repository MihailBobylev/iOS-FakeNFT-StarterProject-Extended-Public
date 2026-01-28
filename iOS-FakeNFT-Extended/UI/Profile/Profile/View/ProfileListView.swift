//
//  ProfileListView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct ProfileListView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
            Spacer()
            Image(.icChevronForward)
                .foregroundStyle(.ypBlack)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    ProfileListView(title: "Мои NFT")
}
