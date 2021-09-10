//
//  CurrencyListScreen.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI

struct CurrencyListView: View {
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(currencyList) { item in
                    NavigationLink(destination: CurrencyDetailView(selectedCurrency: item)){
                        CurrencyRow(currency: item)
                    }
                }
            }
            .navigationTitle("Currencies")
        }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView()
    }
}
