//
//  CurrencyAPIDataSource.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

protocol CurrencyAPIDataSource {
    func exchangeValuesLoaded(baseCurrency:String, exchangeValues: Dictionary<String,Double>)
    func currencyListRetrieved(currencyList: [Currency])
}
