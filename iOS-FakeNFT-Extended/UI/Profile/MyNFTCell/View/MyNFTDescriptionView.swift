//
//  MyNFTDescriptionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTDescriptionView: View {
    var viewModel: MyNFTViewModel
    private let maxRating: Int = 5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.name)
                .font(.title1Bold)
                .foregroundStyle(.ypBlack)
            HStack(spacing: 4) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(index <= viewModel.rating ? "ic_star_selected" : "ic_star_unselected")
                        .foregroundStyle(index <= viewModel.rating ? .ypYellow : .ypLightGray)
                }
            }
            Text("от \(viewModel.author)")
                .font(.footnoteRegular13)
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    let model = MyNFTModel(
        name: "Archie",
        author: "John Doe",
        rating: 1,
        price: 1.78,
        isLiked: true
    )
    let viewModel = MyNFTViewModel(model: model)
    MyNFTDescriptionView(viewModel: viewModel)
}
