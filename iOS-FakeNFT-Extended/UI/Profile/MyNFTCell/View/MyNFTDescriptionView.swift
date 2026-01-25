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
            Text(viewModel.model.name)
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
            HStack(spacing: 4) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(index <= viewModel.model.rating ? "ic_star_selected" : "ic_star_unselected")
                        .foregroundStyle(index <= viewModel.model.rating ? .ypYellow : .ypLightGray)
                }
            }
            Text("от \(viewModel.model.author)")
                .font(.footnoteRegular13)
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    let model = MyNFTCellModel(
        name: "Archie",
        author: "John Doe",
        rating: 1,
        price: 1.78,
        isLiked: true
    )
    let viewModel = MyNFTCellViewModel(model: model)
    MyNFTDescriptionView(viewModel: viewModel)
}
