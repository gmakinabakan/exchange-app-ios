//
//  CurrencyDelegate.swift
//  Exchange
//
//  Created by Gun Makinabakan on 13.09.2021.
//

import Foundation
import CurrencyAPIBase

protocol CurrencyProtocol {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double)
    func currencyListRetrieved(currencyList: [Currency])
}

extension CurrencyProtocol {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double) {}
    func currencyListRetrieved(currencyList: [Currency]) {}
}
