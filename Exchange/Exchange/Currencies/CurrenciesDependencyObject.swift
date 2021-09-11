//
//  CurrenciesDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine

final class CurrenciesDependencyObject: ObservableObject, DataTransferProtocol {
    var uniqueDataKey: String?
    var apiList: [CurrencyAPIProtocol]
    
    init(apiList: [CurrencyAPIProtocol], uniqueDataKey: String?) {
        self.apiList = apiList
        self.uniqueDataKey = uniqueDataKey
    }
}
