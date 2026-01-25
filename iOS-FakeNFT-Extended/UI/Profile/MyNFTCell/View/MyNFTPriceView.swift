//
//  MyNFTPriceView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTPriceView: View {
    var viewModel: MyNFTCellViewModel
//    let price: Double
    var body: some View {
        VStack(alignment: .leading) {
            Text("Price")
                .font(.footnoteRegular13)
                .foregroundStyle(.ypBlack)
            Text("\(viewModel.model.price.formatted(.number.precision(.fractionLength(2)))) ETH")
                .font(.title3Bold)
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
    MyNFTPriceView(viewModel: viewModel)
}
