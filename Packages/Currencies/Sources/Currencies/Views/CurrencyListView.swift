//
//  CurrencyListScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI
import Common
import CurrencyAPIBase

public struct CurrencyListView: View, CurrencyDelegate {
    @EnvironmentObject var dependencyObject: CurrenciesDependencyObject
    @EnvironmentObject var dataTransferObject: DataTransferObservableObject
    @State private var currencyList: [Currency] = []
    
    let currencyHelper = CurrencyHelper()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            List() {
                ForEach(currencyList) { item in
                    NavigationLink(destination: CurrencyDetailView(selectedCurrency: item, currencyList: currencyList)){
                        CurrencyRow(currency: item)
                    }
                }
            }
            .navigationTitle("Currencies")
            .onAppear(perform: {
                var currencyList: [Currency]? = nil
                if let keyData = dependencyObject.uniqueDataKey {
                    if let data = dataTransferObject.DataDictionary[keyData] {
                        print("Retrieving data from data transfer object")
                        let decoder = JSONDecoder()
                        currencyList = try! decoder.decode([Currency].self, from: data)
                    }
                    
                }
                if let currenyListToAssign = currencyList {
                    self.currencyList = currenyListToAssign
                } else {
                    print("Retrieving data from API")
                    self.currencyHelper.initialize(currencyDependency: dependencyObject)
                    currencyHelper.delegate = self
                    currencyHelper.getCurrencyList()
                }
            })
        }
    }
    
    func currencyListRetrieved(currencyList: [Currency]) {
        self.currencyList = currencyList
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    class DummyAPI: CurrencyAPIProtocol{
        var delegate: CurrencyAPIDataSource?
        
        func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {}
        
        func getCurrencyList(requestId: String?) {}
    }
    
    static var previews: some View {
        CurrencyListView()
            .environmentObject(DataTransferObservableObject())
            .environmentObject(CurrenciesDependencyObject(apiList: [DummyAPI()], uniqueDataKey: nil))
    }
}
