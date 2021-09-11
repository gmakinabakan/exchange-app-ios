//
//  DataTransferDependencyObjects.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation
import Combine

final class DataTransferObservableObject: ObservableObject {
    var DataDictionary: Dictionary<String, Data> = [String: Data]()
}
