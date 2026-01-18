//
//  MyNFTCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTCellView: View {
    @State var viewModel: MyNFTViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            MyNFTIconView(viewModel: $viewModel)
            Spacer()
                .frame(width: 20)
            MyNFTDescriptionView(viewModel: viewModel)
            Spacer()
            MyNFTPriceView(viewModel: viewModel)
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
    MyNFTCellView(viewModel: viewModel)
}
