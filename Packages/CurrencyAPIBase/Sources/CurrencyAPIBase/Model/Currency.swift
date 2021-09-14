//
//  Currency.swift
//  Exchange
//
//  Created by Gun Makinabakan on 10.09.2021.
//

import Foundation

public struct Currency: Identifiable, Codable, Hashable {
    public var id: String
    public var flag: String
    public var abbreviation: String
    public var name: String
    public var localeString: String
    
    public init(id: String, flag: String, abbreviation: String, name: String, localeString: String) {
        self.id = id
        self.flag = flag
        self.abbreviation = abbreviation
        self.name = name
        self.localeString = localeString
    }
}
