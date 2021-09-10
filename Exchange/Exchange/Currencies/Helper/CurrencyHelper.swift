//
//  CurrencyHelper.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation

protocol CurrencyDelegate {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double)
}

class CurrencyHelper {
    var delegate: CurrencyDelegate?
    var currencyDependencyObject: CurrenciesDependencyObject?
    
//    init(currencyDependency: CurrenciesDependencyObject) {
//        self.currencyDependencyObject = currencyDependency
//        restAPI.delegate = self
//    }
    func initialize (currencyDependency: CurrenciesDependencyObject) {
        self.currencyDependencyObject = currencyDependency
        self.currencyDependencyObject?.apiList[0].delegate = self
    }
    
    func getRandomCurrency(currentCurrency: Currency) {
        let filteredArray = currencyList.filter {$0.abbreviation != currentCurrency.abbreviation}
        self.currencyDependencyObject?.apiList[0].getExchangeValues(currencyCode: currentCurrency.abbreviation, symbolList: filteredArray.map({$0.abbreviation}))
        
//
//        return filteredArray[Int.random(in: 0..<filteredArray.count)]
    }
    
}

extension CurrencyHelper: CurrencyAPIDataSource {
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>) {
        let randomAbbreviation = Array(exchangeValues.keys)[Int.random(in: 0..<exchangeValues.keys.count)]
        guard let randomCurrency = currencyList.first(where: {$0.abbreviation == randomAbbreviation}) else {
            fatalError("\(randomAbbreviation) currency type is not supported")
        }
        
        guard let exchangeRate = exchangeValues[randomAbbreviation] else {
            fatalError("\(randomAbbreviation) exchange rate is not supported")
        }

        self.delegate?.randomCurrencySelected(currency: randomCurrency, exchangeValue: exchangeRate)
    }
}
