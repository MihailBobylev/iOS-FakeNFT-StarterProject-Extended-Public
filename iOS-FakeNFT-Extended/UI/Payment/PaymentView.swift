//
//  PaymentView.swift
//  NFT Market
//
//  Created by Dmitry on 27.01.2026.
//

import SwiftUI

struct PaymentView: View {
    @Environment(ServicesAssembly.self) private var services
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: PaymentViewModel?
    let currencies: [Currency]
    
    private enum Constants {
        static let navigationTitle = "Выберите способ оплаты"
        static let currencyIconSize: CGFloat = 40
        static let payButtonWidth: CGFloat = 363
        static let payButtonHeight: CGFloat = 60
    }
    
    private static let currencyCellWidth: CGFloat = 168
    private static let columnSpacing: CGFloat = 8
    private var currencyColumns: [GridItem] {
        [
            GridItem(.fixed(Self.currencyCellWidth), spacing: Self.columnSpacing),
            GridItem(.fixed(Self.currencyCellWidth))
        ]
    }
    
    var body: some View {
        Group {
            if let viewModel {
                contentView(viewModel: viewModel)
            } else {
                ProgressView()
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.ypBlack)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            if viewModel == nil {
                viewModel = PaymentViewModel(
                    currencies: currencies,
                    paymentService: services.paymentService
                )
            }
        }
    }
    
    private func contentView(viewModel: PaymentViewModel) -> some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVGrid(columns: currencyColumns, spacing: 6) {
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
            
            Spacer().frame(height: 20)
            
            VStack(spacing: 16) {
                agreementLink
                payButton(viewModel: viewModel)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 50)
            .frame(maxWidth: .infinity)
            .background(
                Color.ypPaymentBackground
                    .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
            )
            .cornerRadius(12, corners: [.topLeft, .topRight])
        }
        .disabled(viewModel.isLoading)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
    private var agreementLink: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Совершая покупку, вы соглашаетесь с условиями")
                .font(.footnoteRegular13)
                .foregroundColor(.ypBlack)
            
            if let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse") {
                Link("Пользовательского соглашения", destination: url)
                    .font(.footnoteRegular13)
                    .foregroundColor(.ypBlue)
            }
        }
    }
    
    private func payButton(viewModel: PaymentViewModel) -> some View {
        Button(action: {
            Task {
                await viewModel.pay()
            }
        }) {
            Text("Оплатить")
                .font(.title3Bold)
                .foregroundColor(viewModel.selectedCurrencyID != nil ? .ypWhite : .ypBlack)
                .frame(width: Constants.payButtonWidth, height: Constants.payButtonHeight)
                .background(viewModel.selectedCurrencyID != nil ? Color.ypBlack : Color.ypButtonDisabled)
                .cornerRadius(16)
        }
        .disabled(viewModel.selectedCurrencyID == nil || viewModel.isLoading)
    }
}

private struct CurrencyCell: View {
    let currency: Currency
    let isSelected: Bool
    let onSelect: () -> Void
    
    private enum Constants {
        static let iconSize: CGFloat = 40
        static let cellWidth: CGFloat = 168
        static let cellHeight: CGFloat = 46
    }
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                Image(iconName(for: currency.ticker))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.iconSize, height: Constants.iconSize)
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
            .frame(width: Constants.cellWidth, height: Constants.cellHeight)
            .background(Color.ypPaymentBackground)
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
    return NavigationStack {
        PaymentView(currencies: Currency.mocks)
    }
    .environment(ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        basketStorage: BasketStorageImpl()
    ))
}

