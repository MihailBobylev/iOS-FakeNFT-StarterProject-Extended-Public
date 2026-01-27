//
//  PaymentView.swift
//  NFT Market
//
//  Created by Dmitry on 27.01.2026.
//

import SwiftUI

struct PaymentView: View {
    @State private var viewModel: PaymentViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    init(viewModel: PaymentViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        @Bindable var bindableViewModel = viewModel
        return VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.currencies) { currency in
                        CurrencyCell(
                            currency: currency,
                            isSelected: viewModel.selectedCurrencyID == currency.id,
                            onSelect: {
                                viewModel.selectCurrency(id: currency.id)
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if viewModel.selectedCurrencyID != nil {
                    viewModel.deselectCurrency()
                }
            }
            
            VStack(spacing: 16) {
                agreementLink
                payButton
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 50)
            .background(Color("ypPaymentBackground"))
            .cornerRadius(12, corners: [.topLeft, .topRight])
        }
        .navigationTitle("Выбор валюты")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var agreementLink: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Совершая покупку, вы соглашаетесь с условиями")
                .font(.footnoteRegular13)
                .foregroundColor(.ypBlack)
            
            Link("Пользовательского соглашения", destination: URL(string: "https://yandex.ru/legal/practicum_termsofuse")!)
                .font(.footnoteRegular13)
                .foregroundColor(.ypBlue)
        }
    }
    
    private var payButton: some View {
        Button(action: {
        }) {
            Text("Оплатить")
                .font(.title3Bold)
                .foregroundColor(viewModel.selectedCurrencyID != nil ? .ypWhite : .ypBlack)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(viewModel.selectedCurrencyID != nil ? Color.ypBlack : Color("ypButtonDisabled"))
                .cornerRadius(16)
        }
        .disabled(viewModel.selectedCurrencyID == nil)
    }
}

private struct CurrencyCell: View {
    let currency: Currency
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                Image(iconName(for: currency.ticker))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(currency.name)
                        .font(.footnoteRegular15)
                        .foregroundColor(.ypBlack)
                    
                    Text(currency.ticker)
                        .font(.footnoteRegular13)
                        .foregroundColor(.ypGreen)
                }
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color("ypPaymentBackground"))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.ypBlack : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func iconName(for ticker: String) -> String {
        switch ticker.uppercased() {
        case "BTC":
            return "Bitcoin"
        case "DOGE":
            return "Dogecoin"
        case "USDT":
            return "Tether"
        case "ETH":
            return "Ethereum"
        case "SOL":
            return "Solana"
        case "APE":
            return "ApeCoin"
        case "ADA":
            return "Cardano"
        case "SHIB":
            return "ShibaInu"
        default:
            return "ic_catalog"
        }
    }
}

#Preview {
    let currencies = [
        Currency(
            id: "1",
            name: "Bitcoin",
            ticker: "BTC",
            imageURL: URL(string: "https://example.com/btc")!
        ),
        Currency(
            id: "2",
            name: "Dogecoin",
            ticker: "DOGE",
            imageURL: URL(string: "https://example.com/doge")!
        ),
        Currency(
            id: "3",
            name: "Tether",
            ticker: "USDT",
            imageURL: URL(string: "https://example.com/usdt")!
        ),
        Currency(
            id: "4",
            name: "ApeCoin",
            ticker: "APE",
            imageURL: URL(string: "https://example.com/ape")!
        ),
        Currency(
            id: "5",
            name: "Ethereum",
            ticker: "ETH",
            imageURL: URL(string: "https://example.com/eth")!
        ),
        Currency(
            id: "6",
            name: "Solana",
            ticker: "SOL",
            imageURL: URL(string: "https://example.com/sol")!
        ),
        Currency(
            id: "7",
            name: "Cardano",
            ticker: "ADA",
            imageURL: URL(string: "https://example.com/ada")!
        ),
        Currency(
            id: "8",
            name: "Shiba Inu",
            ticker: "SHIB",
            imageURL: URL(string: "https://example.com/shib")!
        )
    ]
    
    return NavigationStack {
        PaymentView(viewModel: PaymentViewModel(currencies: currencies))
    }
}

