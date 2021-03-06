//
//  ExchangeApp.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI
import Common
import CurrencyAPIBase
import LocalCache
import FixerAPI
import Welcome
import Currencies

@main
struct ExchangeApp: App {
    @StateObject private var currenciesDependency = CurrenciesDependencyObject(apiList: [CurrencyLocalCache(), FixerRestAPI()], uniqueDataKey: "dc7eb963-c89e-4137-9005-62f6b1e1c7a7")
    
    @StateObject private var welcomeDependency = WelcomeDependencyObject(nextView: AnyView(CurrencyListView()), headerMessage: "Welcome to the currency exchange rate application", captionMessage: "The app, where you can find an exchange rate of the currency that has been added by the developer👌", popupMessage: "We have a lot of new stuff for you", initialDataAPI: FixerRestAPI(), uniqueDataKey: "dc7eb963-c89e-4137-9005-62f6b1e1c7a7")
    
    @StateObject private var dataTransferDependency = DataTransferObservableObject()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currenciesDependency)
                .environmentObject(welcomeDependency)
                .environmentObject(dataTransferDependency)
        }
    }
}
