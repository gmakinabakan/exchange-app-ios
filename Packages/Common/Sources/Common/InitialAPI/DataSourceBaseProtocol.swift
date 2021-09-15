//
//  DataSourceBaseProtocol.swift
//  Exchange
//
//  Created by Gun Makinabakan on 11.09.2021.
//

import Foundation

public protocol DataSourceBaseProtocol: AnyObject {
    func initialDataRetrieved(data: Data)
}
