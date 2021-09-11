//
//  WelcomeDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine
import SwiftUI

final class WelcomeDependencyObject: ObservableObject, DataTransferProtocol {
    var uniqueDataKey: String?
    var initialDataAPI: APIBaseProtocol?
    var nextView: AnyView
    
    
    init(nextView: AnyView, initialDataAPI: APIBaseProtocol?, uniqueDataKey:String?) {
        self.nextView = nextView
        self.initialDataAPI = initialDataAPI
        self.uniqueDataKey = uniqueDataKey
    }
}
