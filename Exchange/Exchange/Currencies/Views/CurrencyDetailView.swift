//
//  CurrencyDetailScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI

struct CurrencyDetailView: View, CurrencyDelegate {
    
    @State private var randomCurrency: (currency:Currency, exchangeRate: Double)? = nil
    var selectedCurrency: Currency
//    @State private var exchangeRate = 0.00
    let currencyHelper = CurrencyHelper()
    
    var body: some View {
        VStack {
            BodyText(text: "Here is an exchange rate for \(selectedCurrency.flag) \(selectedCurrency.abbreviation) and randomly selected \(randomCurrency?.currency.flag ?? "") \(randomCurrency?.currency.abbreviation ?? "?")", color: TextColor.PrimaryDark)
                .padding()
            Headline2(text: "\(selectedCurrency.symbol) 1,00", color: TextColor.PrimaryDark)
                .padding()
            Headline2(text: "↑↓", color: TextColor.Secondary)
                .padding()
            Headline2(text: "\(randomCurrency?.currency.symbol ?? "") \(randomCurrency?.exchangeRate ?? 0.00)", color: TextColor.PrimaryDark)
                .padding()
            Spacer()
            AnimatedButton(text: "REFRESH", action: refreshCurrency, isLoading: false)
                .padding()
        }
        .navigationTitle(selectedCurrency.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            currencyHelper.delegate = self
            refreshCurrency()
        })
    }
    
    private func refreshCurrency() {
        currencyHelper.getRandomCurrency(currentCurrency: selectedCurrency)
    }
    
    func randomCurrencySelected(currency: Currency, exchangeValue: Double) {
        randomCurrency = (currency: currency, exchangeRate: exchangeValue)
    }
}

struct CurrencyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailView(selectedCurrency: currencyList[0])
    }
}
