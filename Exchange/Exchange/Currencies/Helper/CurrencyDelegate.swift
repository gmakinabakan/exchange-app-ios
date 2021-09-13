//
//  CurrencyDelegate.swift
//  Exchange
//
//  Created by Gun Makinabakan on 13.09.2021.
//

import Foundation

protocol CurrencyDelegate {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double)
    func currencyListRetrieved(currencyList: [Currency])
}

extension CurrencyDelegate {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double) {}
    func currencyListRetrieved(currencyList: [Currency]) {}
}
