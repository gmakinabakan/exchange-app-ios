//
//  CurrenciesDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine

final class CurrenciesDependencyObject: ObservableObject {
    var apiList: [CurrencyAPIBase]
    
    init(apiList: [CurrencyAPIBase]) {
        self.apiList = apiList
    }
}
