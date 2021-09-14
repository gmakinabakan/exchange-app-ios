//
//  File.swift
//  
//
//  Created by Gun Makinabakan on 14.09.2021.
//

import Foundation

struct FixerListReponse: Codable, Hashable {
    var success: Bool
    var symbols: Dictionary<String, String>
}
