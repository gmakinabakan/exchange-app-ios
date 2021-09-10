//
//  CurrencyHelper.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation

protocol CurrencyDelegate {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double)
    func currencyListRetrieved(currencyList: [Currency])
}

class CurrencyHelper {
    var delegate: CurrencyDelegate?
    var currencyDependencyObject: CurrenciesDependencyObject?
    var currencyList: [Currency]?
    
    func initialize (currencyDependency: CurrenciesDependencyObject) {
        self.currencyDependencyObject = currencyDependency
        self.currencyDependencyObject?.apiList[0].delegate = self
    }
    
    func getRandomCurrency(currentCurrency: Currency) {
        if let filteredArray = (currencyList?.filter {$0.abbreviation != currentCurrency.abbreviation}) {
            self.currencyDependencyObject?.apiList[0].getExchangeValues(currencyCode: currentCurrency.abbreviation, symbolList: filteredArray.map({$0.abbreviation}))
        }
    }
    
    func getCurrencyList() {
        self.currencyDependencyObject?.apiList[0].getCurrencyList()
    }
}

extension CurrencyHelper: CurrencyAPIDataSource {
    func currencyListRetrieved(currencyList: [Currency]) {
        self.currencyList = currencyList
        self.delegate?.currencyListRetrieved(currencyList: currencyList)
    }
    
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>) {
        let randomAbbreviation = Array(exchangeValues.keys)[Int.random(in: 0..<exchangeValues.keys.count)]
        guard let randomCurrency = currencyList?.first(where: {$0.abbreviation == randomAbbreviation}) else {
            fatalError("\(randomAbbreviation) currency type is not supported")
        }
        
        guard let exchangeRate = exchangeValues[randomAbbreviation] else {
            fatalError("\(randomAbbreviation) exchange rate is not supported")
        }
        
        self.delegate?.randomCurrencySelected(currency: randomCurrency, exchangeValue: exchangeRate)
    }
}
