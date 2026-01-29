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
    var isLoading = false
    var paymentSuccess = false
    var paymentError: Error?
    
    private let paymentService: PaymentService
    
    init(currencies: [Currency] = [], paymentService: PaymentService) {
        self.currencies = currencies
        self.paymentService = paymentService
    }
    
    var selectedCurrency: Currency? {
        guard let id = selectedCurrencyID else { return nil }
        return currencies.first { $0.id == id }
    }
    
    func selectCurrency(id: String) {
        selectedCurrencyID = id
    }
    
    func deselectCurrency() {
        selectedCurrencyID = nil
    }
    
    func pay() async {
        guard let selectedCurrencyID else { return }
        
        isLoading = true
        paymentError = nil
        
        do {
            let response = try await paymentService.pay(currencyId: selectedCurrencyID)
            paymentSuccess = response.success
        } catch {
            paymentError = error
        }
        
        isLoading = false
    }
}

