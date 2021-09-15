//
//  WelcomeDependencyObject.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation
import Combine
import SwiftUI
import Common

public final class WelcomeDependencyObject: ObservableObject, DataTransferProtocol {
    public var nextView: AnyView
    public var headerMessage: String
    public var captionMessage: String
    public var popupMessage: String
    public var initialDataAPI: APIBaseProtocol?
    public var uniqueDataKey: String?
    
    public init(nextView: AnyView, headerMessage: String, captionMessage: String, popupMessage: String, initialDataAPI: APIBaseProtocol?, uniqueDataKey:String?) {
        self.nextView = nextView
        self.headerMessage = headerMessage
        self.captionMessage = captionMessage
        self.popupMessage = popupMessage
        self.initialDataAPI = initialDataAPI
        self.uniqueDataKey = uniqueDataKey
    }
}
