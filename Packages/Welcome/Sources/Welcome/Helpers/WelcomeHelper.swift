//
//  File.swift
//  
//
//  Created by Gun Makinabakan on 15.09.2021.
//

import Foundation
import Common

class WelcomeHelper {
    var initialAPI: APIBaseProtocol?
    var uniqueDataKey: String?
    var delegate: WelcomeDataProtocol?
    var dataTransferObject: DataTransferObservableObject?
    
    func initialize(initialAPI: APIBaseProtocol?, uniqueDataKey: String?, dataTransferObject: DataTransferObservableObject?) {
        self.initialAPI = initialAPI
        self.uniqueDataKey = uniqueDataKey
        self.initialAPI?.baseDelegate = self
        self.dataTransferObject = dataTransferObject
    }
    
    func loadData() {
        if let api = initialAPI {
            api.initialCall()
        } else {
            self.delegate?.dataRetrievalCompleted()
        }
        
    }
}

extension WelcomeHelper: DataSourceBaseProtocol {
    func initialDataRetrieved(data: Data) {
        if let dataKey = uniqueDataKey
        {
            print(data)
            self.dataTransferObject?.dataDictionary[dataKey] = data
            self.delegate?.dataRetrievalCompleted()
        }
    }
}
