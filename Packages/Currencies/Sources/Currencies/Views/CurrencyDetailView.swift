//
//  CurrencyDetailScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI
import Swift
import CurrencyAPIBase
import DesignSystem

struct CurrencyDetailView: View, CurrencyProtocol {
    @EnvironmentObject var dependencyObject: CurrenciesDependencyObject
    @State private var randomCurrency: (currency:Currency, exchangeRate: Double)? = nil
    @State private var isLoading = false
    
    var selectedCurrency: Currency
    var currencyList: [Currency]
    
    let currencyHelper = CurrencyHelper()
    let localFormatter = NumberFormatter()
    let randomFormatter = NumberFormatter()
    
    var body: some View {
        ZStack {
            ApplicationBackgroundColor.backgroundColor
                .ignoresSafeArea()
            VStack {
                BodyText(text: "Here is an exchange rate for \(selectedCurrency.flag) \(selectedCurrency.abbreviation) and randomly selected \(randomCurrency?.currency.flag ?? "") \(randomCurrency?.currency.abbreviation ?? "?")", color: TextColor.primary)
                    .padding()
                Headline2(text: "\(localFormatter.string(from: 1.00)!)", color: TextColor.primary)
                    .padding()
                Headline2(text: "↑↓", color: ApplicationColor.primary)
                    .padding()
                if (randomCurrency == nil) {
                    Headline2(text: "N/A", color: TextColor.primary)
                        .redacted(reason: .placeholder)
                } else {
                    Headline2(text: "\(randomFormatter.string(from: NSNumber(value: randomCurrency!.exchangeRate))!)", color: TextColor.primary)
                        .padding()
                }
                
                Spacer()
                if (isLoading) {
                    AnimatedButton(text: "REFRESH", action: refreshCurrency, isLoading: true)
                        .padding()
                } else {
                    AnimatedButton(text: "REFRESH", action: refreshCurrency, isLoading: false)
                        .padding()
                }
            }
            .navigationTitle(selectedCurrency.name)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                localFormatter.numberStyle = .currency
                localFormatter.locale = Locale(identifier: selectedCurrency.localeString)
                randomFormatter.numberStyle = .currency
                self.currencyHelper.initialize(apiList: dependencyObject.apiList, uniqueDataKey: dependencyObject.uniqueDataKey, dataTransferObject: nil)
                currencyHelper.delegate = self
                currencyHelper.currencyList = currencyList
                refreshCurrency()
        })
        }
    }
    
    private func refreshCurrency() {
        currencyHelper.getRandomCurrency(currentCurrency: selectedCurrency)
        isLoading.toggle()
    }
    
    func randomCurrencySelected(currency: Currency, exchangeValue: Double) {
        randomFormatter.locale = Locale(identifier: currency.localeString)
        randomCurrency = (currency: currency, exchangeRate: exchangeValue)
        isLoading.toggle()
    }
}


struct CurrencyDetailView_Previews: PreviewProvider {
    class DummyAPI: CurrencyAPIProtocol{
        weak var delegate: CurrencyAPIDataSource?
        
        func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {}
        
        func getCurrencyList(requestId: String?) {}
    }
    
    static var previews: some View {
        CurrencyDetailView(selectedCurrency: Currency(id: "TRY", flag: "🇹🇷", abbreviation: "TRY", name: "Turkish Lira", localeString: "tr_TR"), currencyList: [Currency(id: "TRY", flag: "🇹🇷", abbreviation: "TRY", name: "Turkish Lira", localeString: "tr_TR")])
            .environmentObject(CurrenciesDependencyObject(apiList: [DummyAPI()], uniqueDataKey: nil))
    }
}
