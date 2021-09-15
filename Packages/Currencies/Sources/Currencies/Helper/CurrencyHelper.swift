//
//  CurrencyHelper.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation
import CurrencyAPIBase
import Common

class CurrencyHelper {
    var delegate: CurrencyDelegate?
    var currencyList: [Currency]?
    var dataHelper: CurrencyAPIHelper?
    var uniqueDataKey: String?
    var dataTransferObject: DataTransferObservableObject?
    
    func initialize (apiList: [CurrencyAPIProtocol], uniqueDataKey: String?, dataTransferObject: DataTransferObservableObject?) {
        self.dataHelper = CurrencyAPIHelper(apiList: apiList)
        self.dataHelper?.delegate = self
        self.uniqueDataKey = uniqueDataKey
        self.dataTransferObject = dataTransferObject
    }
    
    func getRandomCurrency(currentCurrency: Currency) {
        if let filteredArray = (currencyList?.filter {$0.abbreviation != currentCurrency.abbreviation}) {
            self.dataHelper?.getExchangeValues(currencyCode: currentCurrency.abbreviation, symbolList: filteredArray.map({$0.abbreviation}), requestId: nil)
        }
    }
    
    func getCurrencyList() {
        if let keyData = uniqueDataKey {
            if let data = dataTransferObject?.DataDictionary[keyData] {
                print("Retrieving data from data transfer object")
                let decoder = JSONDecoder()
                currencyList = try! decoder.decode([Currency].self, from: data)
                self.delegate?.currencyListRetrieved(currencyList: currencyList!)
                return
            }
            
        }
        print("Retrieving data from API")
        self.dataHelper?.getCurrencyList(requestId: nil)
    }
}

extension CurrencyHelper: CurrencyAPIDataSource {    
    func currencyListRetrieved(currencyList: [Currency], requestId: String?) {
        self.currencyList = currencyList
        self.delegate?.currencyListRetrieved(currencyList: currencyList)
    }
    
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>, requestId: String?) {
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
