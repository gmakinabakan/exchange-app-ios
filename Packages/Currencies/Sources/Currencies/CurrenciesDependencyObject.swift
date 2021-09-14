//
//  CurrenciesDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine
import Common
import CurrencyAPIBase

public final class CurrenciesDependencyObject: ObservableObject, DataTransferProtocol {
    public var uniqueDataKey: String?
    public var apiList: [CurrencyAPIProtocol]
    
    public init(apiList: [CurrencyAPIProtocol], uniqueDataKey: String?) {
        self.apiList = apiList
        self.uniqueDataKey = uniqueDataKey
    }
}
