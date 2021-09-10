//
//  CurrencyAPIProtocol.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

protocol CurrencyAPIProtocol {
    func getExchangeValues(currencyCode: String, symbolList: [String])
    func setCache()
}
