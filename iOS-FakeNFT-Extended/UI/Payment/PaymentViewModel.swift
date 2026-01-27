//
//  PaymentViewModel.swift
//  NFT Market
//
//  Created by Dmitry on 27.01.2026.
//

import Foundation

@Observable
final class PaymentViewModel {
    
    var currencies: [Currency]
    var selectedCurrencyID: String?
    
    init(currencies: [Currency] = []) {
        self.currencies = currencies
    }
    
    var selectedCurrency: Currency? {
        guard let id = selectedCurrencyID else { return nil }
        return currencies.first { $0.id == id }
    }
}

