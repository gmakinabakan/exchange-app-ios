//
//  CurrencyListScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI
import Common
import CurrencyAPIBase
import DesignSystem

public struct CurrencyListView: View, CurrencyProtocol {
    @EnvironmentObject var dependencyObject: CurrenciesDependencyObject
    @EnvironmentObject var dataTransferObject: DataTransferObservableObject
    @State private var currencyList: [Currency] = []
    
    let currencyHelper = CurrencyHelper()
    
    public init() {}
    
    public var body: some View {
        ZStack {
            ApplicationBackgroundColor.backgroundColor
                .ignoresSafeArea()
            NavigationView {
                List() {
                    ForEach(currencyList) { item in
                        ZStack {
                            NavigationLink(destination: CurrencyDetailView(selectedCurrency: item, currencyList: currencyList)) {
                                EmptyView()
                            }.hidden()
                            CurrencyRow(currency: item)
                        }
                        .listRowBackground(ApplicationBackgroundColor.backgroundColor)
                    }
                }
                .navigationTitle("Currencies")
                .background(ApplicationBackgroundColor.backgroundColor)
                .ignoresSafeArea()
                .onAppear(perform: {
                    self.currencyHelper.initialize(apiList: dependencyObject.apiList, uniqueDataKey: dependencyObject.uniqueDataKey, dataTransferObject: dataTransferObject)
                    currencyHelper.delegate = self
                    currencyHelper.getCurrencyList()
                })
            }
            .accentColor(ApplicationColor.primary)
        }
    }
    
    func currencyListRetrieved(currencyList: [Currency]) {
        self.currencyList = currencyList
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    class DummyAPI: CurrencyAPIProtocol{
        var isCache: Bool = false
        
        weak var delegate: CurrencyAPIDataSource?
        
        func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {}
        
        func getCurrencyList(requestId: String?) {}
    }
    
    
    static var previews: some View {
        CurrencyListView()
            .environmentObject(DataTransferObservableObject())
            .environmentObject(CurrenciesDependencyObject(apiList: [DummyAPI()], uniqueDataKey: nil))
    }
    
}
