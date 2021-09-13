//
//  CurrencyDetailScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI
import Swift

struct CurrencyDetailView: View, CurrencyDelegate {
    @EnvironmentObject var dependencyObject: CurrenciesDependencyObject
    @State private var randomCurrency: (currency:Currency, exchangeRate: Double)? = nil
    
    var selectedCurrency: Currency
    var currencyList: [Currency]
    
    let currencyHelper = CurrencyHelper()
    let localFormatter = NumberFormatter()
    let randomFormatter = NumberFormatter()
    
    var body: some View {
        VStack {
            BodyText(text: "Here is an exchange rate for \(selectedCurrency.flag) \(selectedCurrency.abbreviation) and randomly selected \(randomCurrency?.currency.flag ?? "") \(randomCurrency?.currency.abbreviation ?? "?")", color: TextColor.Primary)
                .padding()
            Headline2(text: "\(localFormatter.string(from: 1.00)!)", color: TextColor.Primary)
                .padding()
            Headline2(text: "↑↓", color: TextColor.Secondary)
                .padding()
            if (randomCurrency == nil) {
                Headline2(text: "N/A", color: TextColor.Primary)
                    .redacted(reason: .placeholder)
            } else {
                Headline2(text: "\(randomFormatter.string(from: NSNumber(value: randomCurrency!.exchangeRate))!)", color: TextColor.Primary)
                    .padding()
            }
            
            Spacer()
            AnimatedButton(text: "REFRESH", action: refreshCurrency, isLoading: false)
                .padding()
        }
        .navigationTitle(selectedCurrency.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            localFormatter.numberStyle = .currency
            localFormatter.locale = Locale(identifier: selectedCurrency.localeString)
            randomFormatter.numberStyle = .currency
            self.currencyHelper.initialize(currencyDependency: dependencyObject)
            currencyHelper.delegate = self
            currencyHelper.currencyList = currencyList
            refreshCurrency()
        })
    }
    
    private func refreshCurrency() {
        currencyHelper.getRandomCurrency(currentCurrency: selectedCurrency)
    }
    
    func randomCurrencySelected(currency: Currency, exchangeValue: Double) {
        randomFormatter.locale = Locale(identifier: currency.localeString)
        randomCurrency = (currency: currency, exchangeRate: exchangeValue)
    }
    
    func currencyListRetrieved(currencyList: [Currency]) {}
}

struct CurrencyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetailView(selectedCurrency: Currency(id: "TRY", flag: "🇹🇷", abbreviation: "TRY", name: "Turkish Lira", localeString: "tr_TR"), currencyList: [Currency(id: "TRY", flag: "🇹🇷", abbreviation: "TRY", name: "Turkish Lira", localeString: "tr_TR")])
    }
}
