//
//  NumberFormatters+Presets.swift
//  NFT Market
//
//  Created by Dmitry on 02.02.2026.
//

import Foundation

extension NumberFormatter {
    static let ethPrice: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        f.decimalSeparator = "."
        return f
    }()
}
