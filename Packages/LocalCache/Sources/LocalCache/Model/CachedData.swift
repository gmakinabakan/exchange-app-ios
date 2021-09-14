//
//  CacheModel.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation

public struct CachedData: Codable, Hashable {
    var expirationTimestamp: Double
    var data: Data
    
    public init(expirationTimestamp: Double, data: Data) {
        self.expirationTimestamp = expirationTimestamp
        self.data = data
    }
}
