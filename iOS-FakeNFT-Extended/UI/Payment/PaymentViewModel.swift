//
//  PaymentViewModel.swift
//  NFT Market
//
//  Created by Dmitry on 27.01.2026.
//

import Foundation

@Observable
final class PaymentViewModel {
    
    var currencies: [Currency] = []
    var selectedCurrencyID: String?
    var isLoading = false
    var paymentSuccess = false
    var paymentError: Error?
    var loadCurrenciesError: Error?
    
    private let currencyService: CurrencyService
    private let paymentService: PaymentService
    
    init(currencyService: CurrencyService, paymentService: PaymentService) {
        self.currencyService = currencyService
        self.paymentService = paymentService
    }
    
    func loadCurrencies() async {
        isLoading = true
        loadCurrenciesError = nil
        defer { isLoading = false }
        do {
            currencies = try await currencyService.loadCurrencies()
        } catch {
            loadCurrenciesError = error
        }
    }
    
    var selectedCurrency: Currency? {
        guard let id = selectedCurrencyID else { return nil }
        return currencies.first { $0.id == id }
    }
    
    var showErrorAlert: Bool {
        paymentError != nil
    }
    
    func dismissError() {
        paymentError = nil
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

