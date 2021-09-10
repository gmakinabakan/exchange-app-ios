//
//  CurrencyDetailScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI

struct CurrencyDetailView: View, CurrencyDelegate {
    @EnvironmentObject var dependencyObject: CurrenciesDependencyObject
    @State private var randomCurrency: (currency:Currency, exchangeRate: Double)? = nil
    
    var selectedCurrency: Currency
    let currencyHelper = CurrencyHelper()
    
    var body: some View {
        VStack {
            BodyText(text: "Here is an exchange rate for \(selectedCurrency.flag) \(selectedCurrency.abbreviation) and randomly selected \(randomCurrency?.currency.flag ?? "") \(randomCurrency?.currency.abbreviation ?? "?")", color: TextColor.Primary)
                .padding()
            Headline2(text: "\(selectedCurrency.symbol) 1,00", color: TextColor.Primary)
                .padding()
            Headline2(text: "↑↓", color: TextColor.Secondary)
                .padding()
            if (randomCurrency == nil) {
                Headline2(text: "N/A", color: TextColor.Primary)
                    .redacted(reason: .placeholder)
            } else {
                Headline2(text: "\(randomCurrency?.currency.symbol ?? "") \(randomCurrency?.exchangeRate ?? 0.00)", color: TextColor.Primary)
                    .padding()
            }
            
            Spacer()
            AnimatedButton(text: "REFRESH", action: refreshCurrency, isLoading: false)
                .padding()
        }
        .navigationTitle(selectedCurrency.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            self.currencyHelper.initialize(currencyDependency: dependencyObject)
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
