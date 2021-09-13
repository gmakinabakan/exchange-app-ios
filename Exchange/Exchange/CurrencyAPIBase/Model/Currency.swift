//
//  Currency.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

struct Currency: Identifiable, Codable, Hashable {
    var id: String
    var flag: String
    var abbreviation: String
    var name: String
    var localeString: String
}