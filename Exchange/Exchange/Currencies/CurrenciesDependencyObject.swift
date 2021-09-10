//
//  CurrenciesDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine

final class CurrenciesDependencyObject: ObservableObject {
    var apiList: [CurrencyAPIProtocol]
    
    init(apiList: [CurrencyAPIProtocol]) {
        self.apiList = apiList
    }
}
