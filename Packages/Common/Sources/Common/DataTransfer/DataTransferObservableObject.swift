//
//  DataTransferDependencyObjects.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation
import Combine

public final class DataTransferObservableObject: ObservableObject {
    public var DataDictionary: Dictionary<String, Data> = [String: Data]()
    
    public init() {}
}
