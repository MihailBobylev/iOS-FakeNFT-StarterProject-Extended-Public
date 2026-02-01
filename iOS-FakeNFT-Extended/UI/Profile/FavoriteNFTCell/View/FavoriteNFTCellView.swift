//
//  FavoriteNFTCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 18.01.2026.
//

import SwiftUI

struct FavoriteNFTCellView: View {
    var cellViewModel: FavoriteNFTCellViewModel

    var body: some View {
        HStack(alignment: .center) {
            FavoriteNFTCellIconView(viewModel: cellViewModel)
            Spacer()
            FavoriteNFTCellDescriptionView(viewModel: cellViewModel)
        }
    }
}
