//
//  CurrencyAPIProtocol.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

public protocol CurrencyAPIProtocol {
    var isCache: Bool {get set}
    var delegate: CurrencyAPIDataSource? {get set}
    func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?)
    func getCurrencyList(requestId: String?)
    func setCurrencyListCache(currencyArray: [Currency], expiresIn: Double)
    func setCurrencyExchangeValueCache(baseCurrency: String, exchangeValues: Dictionary<String, Double>, symbolList: [String], expiresIn: Double)
}

public extension CurrencyAPIProtocol {
    func setCurrencyListCache(currencyArray: [Currency], expiresIn: Double) {}
    func setCurrencyExchangeValueCache(baseCurrency: String, exchangeValues: Dictionary<String, Double>, symbolList: [String], expiresIn: Double) {}
}
