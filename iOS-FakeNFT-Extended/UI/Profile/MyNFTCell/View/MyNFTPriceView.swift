//
//  MyNFTPriceView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTPriceView: View {
    enum Constants {
        static let price = "Price"
    }
    var viewModel: MyNFTCellViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.price)
                .font(.footnoteRegular13)
                .foregroundStyle(.ypBlack)
            Text("\((viewModel.model.price ?? 0).formatted(.number.precision(.fractionLength(2)))) ETH")
                .font(.title3Bold)
                .foregroundStyle(.ypBlack)
        }
    }
}
