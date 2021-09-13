//
//  DataHelper.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation

struct RequestInformation {
    var apiIndex: Int
    var symbolList: [String]?
}

class DataHelper {
    var apiList: [CurrencyAPIProtocol]
    var delegate: CurrencyAPIDataSource?
    var requestDictionary = Dictionary<String, RequestInformation> ()
    
    init(apiList: [CurrencyAPIProtocol]) {
        self.apiList = apiList
        for i in 0...apiList.count - 1 {
            self.apiList[i].delegate = self
        }
    }
}

extension DataHelper: CurrencyAPIProtocol {
    func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {
        if let oldRequestId = requestId {
            if let oldRequest = requestDictionary[oldRequestId] {
                
                self.apiList[(oldRequest.apiIndex + 1)].getExchangeValues(currencyCode: currencyCode, symbolList: symbolList, requestId: oldRequestId)
            }
        } else {
            let request = RequestInformation(apiIndex: 0, symbolList: symbolList)
            let newRequestId = UUID().uuidString
            requestDictionary[newRequestId] = request
            self.apiList[0].getExchangeValues(currencyCode: currencyCode, symbolList: symbolList, requestId: newRequestId)
        }
        
    }
    
    func getCurrencyList(requestId: String?) {
        if let oldRequestId = requestId {
            if let oldRequest = requestDictionary[oldRequestId] {
                self.apiList[(oldRequest.apiIndex + 1)].getCurrencyList(requestId: oldRequestId)
            }
        } else {
            let request = RequestInformation(apiIndex: 0, symbolList: nil)
            let newRequestId = UUID().uuidString
            requestDictionary[newRequestId] = request
            self.apiList[0].getCurrencyList(requestId: UUID().uuidString)
        }
    }
}

extension DataHelper: CurrencyAPIDataSource {
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>, requestId: String?) {
        if let oldRequestId = requestId, let oldRequest = requestDictionary[oldRequestId] {
            if (exchangeValues.count > 0 || oldRequest.apiIndex == apiList.count - 1) {
                self.apiList.forEach { api in
                    print("Exchange values loaded")
                    api.setCurrencyExchangeValueCache(baseCurrency: baseCurrency, exchangeValues: exchangeValues, symbolList: oldRequest.symbolList!, expiresIn: 600)
                }
                self.delegate?.exchangeValuesLoaded(baseCurrency: baseCurrency, exchangeValues: exchangeValues, requestId: nil)
            } else {
                self.getExchangeValues(currencyCode: baseCurrency, symbolList: oldRequest.symbolList!, requestId: oldRequestId)
            }
        }
    }
    
    func currencyListRetrieved(currencyList: [Currency], requestId: String?) {
        if let oldRequestId = requestId, let oldRequest = requestDictionary[oldRequestId] {
            if (currencyList.count > 0 || oldRequest.apiIndex == apiList.count - 1) {
                self.apiList.forEach { api in
                    api.setCurrencyListCache(currencyArray: currencyList, expiresIn: 600)
                }
                self.delegate?.currencyListRetrieved(currencyList: currencyList, requestId: nil)
            } else {
                self.getCurrencyList(requestId: oldRequestId)
            }
        }
    }
}

