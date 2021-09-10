//
//  CurrencyAPIProtocol.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

protocol CurrencyAPIProtocol {
    var delegate: CurrencyAPIDataSource? {get set}
    func getExchangeValues(currencyCode: String, symbolList: [String])
    func setCache()
}
