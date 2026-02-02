//
//  PaymentView.swift
//  NFT Market
//
//  Created by Dmitry on 27.01.2026.
//

import Kingfisher
import SwiftUI

struct PaymentView: View {
    @Environment(ServicesAssembly.self) private var services
    @Environment(NavigationRouter.self) private var router
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: PaymentViewModel?
    @State private var currencies: [Currency] = []
    
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
        .background(bottomPanelBackground)
        .task {
            guard viewModel == nil else { return }
            if currencies.isEmpty {
                do {
                    currencies = try await services.currencyService.loadCurrencies()
                } catch {
                    currencies = Currency.mocks
                }
            }
            viewModel = PaymentViewModel(
                currencies: currencies,
                paymentService: services.paymentService
            )
        }
        .onChange(of: viewModel?.paymentSuccess) { _, newValue in
            if newValue == true {
                router.push(.paymentSuccess)
            }
        }
        .alert(
            "Не удалось произвести оплату",
            isPresented: Binding(
                get: { viewModel?.showErrorAlert ?? false },
                set: { if !$0 { viewModel?.dismissError() } }
            )
        ) {
            Button("Отмена", role: .cancel) {
                viewModel?.dismissError()
            }
            Button("Повторить") {
                Task {
                    await viewModel?.pay()
                }
            }
        }
    }
    
    private var bottomPanelBackground: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Spacer()
                Color.ypPaymentBackground
                    .frame(height: max(200, geo.safeAreaInsets.bottom + 150))
                    .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
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
            
            Button(action: { router.push(.webView) }) {
                Text("Пользовательского соглашения")
                    .font(.footnoteRegular13)
                    .foregroundColor(.ypBlue)
                    .underline()
            }
            .buttonStyle(.plain)
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
                currencyImageView
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
    
    @ViewBuilder
    private var currencyImageView: some View {
        KFImage(currency.imageURL)
            .placeholder {
                Image(iconName(for: currency.ticker))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
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
        PaymentView()
    }
    .environment(ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        basketStorage: BasketStorageImpl()
    ))
}

