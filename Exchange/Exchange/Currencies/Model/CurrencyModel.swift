//
//  CurrencyModel.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation

struct Currency: Identifiable, Codable, Hashable {
    var id: Int
    var flag: String
    var abbreviation: String
    var name: String
    var symbol: String
}

var currencyList: [Currency] = [
    Currency(id: 1,flag: "🇪🇺",abbreviation: "EUR",name: "Euro", symbol: "€"),
    Currency(id: 2,flag: "🇺🇸",abbreviation: "USD",name: "US Dollar", symbol: "$"),
    Currency(id: 3,flag: "🇬🇧",abbreviation: "GBP",name: "British Pound", symbol: "£"),
    Currency(id: 4,flag: "🇨🇭",abbreviation: "CHF",name: "Swiss Franc", symbol: "CHF"),
    Currency(id: 5,flag: "🇸🇦",abbreviation: "SAR",name: "Saudi Riyal", symbol: "﷼"),
    Currency(id: 6,flag: "🇹🇷",abbreviation: "TRY",name: "Turkish Lira", symbol: "₺"),
    Currency(id: 7,flag: "🇯🇵",abbreviation: "JPY",name: "Japanese Yen", symbol: "¥"),
    Currency(id: 8,flag: "🇧🇷",abbreviation: "BRL",name: "Brazilian Real", symbol: "R$"),
    Currency(id: 9,flag: "🇨🇿",abbreviation: "CZK",name: "Czech Koruna", symbol: "Kč"),
    Currency(id: 10,flag: "🇷🇺",abbreviation: "RUB",name: "Russian Ruble", symbol: "₽"),
]

