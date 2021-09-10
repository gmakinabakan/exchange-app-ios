//
//  FixerResponse.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

struct FixerResponse: Codable, Hashable {
    var success: Bool
    var timestamp: Int
    var base: String
    var date: String
    var rates: Dictionary<String, Double>
}
