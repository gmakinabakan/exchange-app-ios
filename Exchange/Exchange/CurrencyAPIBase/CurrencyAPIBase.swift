//
//  CurrencyAPIBase.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
class CurrencyAPIBase: CurrencyAPIProtocol {
    var delegate: CurrencyAPIDataSource?
    func getExchangeValues(currencyCode: String, symbolList: [String]) {}
    func setCache() {}
}
