//
//  ExchangeApp.swift
//  Exchange
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import SwiftUI

@main
struct ExchangeApp: App {
    @StateObject private var currenciesDependency = CurrenciesDependencyObject(apiList: [FixerRestAPI()])
    @StateObject private var welcomeDependency = WelcomeDependencyObject(nextView: AnyView(CurrencyListView()))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currenciesDependency)
                .environmentObject(welcomeDependency)
        }
    }
}
