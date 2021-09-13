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
    var nextView: AnyView
    var headerMessage: String
    var captionMessage: String
    var initialDataAPI: APIBaseProtocol?
    var uniqueDataKey: String?
    
    init(nextView: AnyView, headerMessage: String, captionMessage: String, initialDataAPI: APIBaseProtocol?, uniqueDataKey:String?) {
        self.nextView = nextView
        self.headerMessage = headerMessage
        self.captionMessage = captionMessage
        self.initialDataAPI = initialDataAPI
        self.uniqueDataKey = uniqueDataKey
    }
}
