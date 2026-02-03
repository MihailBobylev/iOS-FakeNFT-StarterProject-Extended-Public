//
//  MyNFTDescriptionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTDescriptionView: View {
    var viewModel: MyNFTCellViewModel
    private let maxRating: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.model.name ?? "")
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
            HStack(spacing: 4) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(index <= viewModel.model.rating ?? 0 ? .icStarSelected : .icStarUnselected)
                        .foregroundStyle(index <= viewModel.model.rating ?? 0 ? .ypYellow : .ypLightGray)
                }
            }
            Text("от \(viewModel.model.author ?? "")")
                .font(.footnoteRegular13)
                .foregroundStyle(.ypBlack)
        }
    }
}
