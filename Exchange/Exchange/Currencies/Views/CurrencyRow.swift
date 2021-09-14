//
//  CurrencyRow.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import SwiftUI
import CurrencyAPIBase
import DesignSystem

struct CurrencyRow: View {
    var currency: Currency

    var body: some View {
        HStack {
            BodyText(text: currency.flag, color: TextColor.Primary)
            BodyText(text: currency.abbreviation, color: TextColor.Primary)
            Spacer()
            Caption(text: currency.name, color: TextColor.Secondary)
        }
        .padding()
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow(currency: Currency(id: "TRY", flag: "🇹🇷", abbreviation: "TRY", name: "Turkish Lira", localeString: "tr_TR"))
    }
}
