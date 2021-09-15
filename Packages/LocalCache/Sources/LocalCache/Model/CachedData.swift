//
//  CacheModel.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation

struct CachedData: Codable, Hashable {
    var expirationTimestamp: Double
    var data: Data
}
