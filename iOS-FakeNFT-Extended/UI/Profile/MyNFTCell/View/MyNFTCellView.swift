//
//  MyNFTCellView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Александр Клопков on 17.01.2026.
//

import SwiftUI

struct MyNFTCellView: View {
    var cellViewModel: MyNFTCellViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            MyNFTIconView(viewModel: cellViewModel)
            Spacer()
                .frame(width: 20)
            MyNFTDescriptionView(viewModel: cellViewModel)
            Spacer()
            MyNFTPriceView(viewModel: cellViewModel)
        }
    }
}
