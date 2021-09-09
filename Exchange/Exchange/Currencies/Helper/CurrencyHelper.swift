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
    private let restAPI = FixerRestAPI()
    var delegate: CurrencyDelegate?
    
    init() {
        restAPI.delegate = self
    }
    
    func getRandomCurrency(currentCurrency: Currency) {
        let filteredArray = currencyList.filter {$0.abbreviation != currentCurrency.abbreviation}
        restAPI.getExchangeValues(currencyCode: currentCurrency.abbreviation, symbolList: filteredArray.map({$0.abbreviation}))
        
//
//        return filteredArray[Int.random(in: 0..<filteredArray.count)]
    }
    
}

extension CurrencyHelper: CurrencyDataSource {
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>) {
        let selectedCurrency = currencyList.first(where: {$0.abbreviation == baseCurrency})
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
