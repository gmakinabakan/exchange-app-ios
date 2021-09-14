//
//  APIBaseProtocol.swift
//  Exchange
//
//  Created by Gun Makinabakan on 11.09.2021.
//

import Foundation

public protocol APIBaseProtocol {
    var baseDelegate: DataSourceBaseProtocol? {get set}
    func initialCall()
}
