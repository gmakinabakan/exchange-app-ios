//
//  CurrencyListScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI

struct CurrencyListView: View, CurrencyDelegate {
    @EnvironmentObject var dependencyObject: CurrenciesDependencyObject
    @EnvironmentObject var dataTransferObject: DataTransferObservableObject
    @State private var currencyList: [Currency] = []
    
    let currencyHelper = CurrencyHelper()
    var body: some View {
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
                        print("Retrieving data from data transfer")
                        let decoder = JSONDecoder()
                        currencyList = try! decoder.decode([Currency].self, from: data)
                    }
                    
                }
                if let currenyListToAssign = currencyList {
                    self.currencyList = currenyListToAssign
                }
                else {
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
    
    func randomCurrencySelected(currency: Currency, exchangeValue: Double) {}
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
