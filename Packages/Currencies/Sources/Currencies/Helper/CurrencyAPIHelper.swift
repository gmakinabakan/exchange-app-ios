//
//  DataHelper.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation
import CurrencyAPIBase

struct RequestInformation {
    var apiIndex: Int
    var symbolList: [String]?
}

class CurrencyAPIHelper {
    var apiList: [CurrencyAPIProtocol]
    weak var delegate: CurrencyAPIDataSource?
    var requestDictionary = Dictionary<String, RequestInformation> ()
    
    init(apiList: [CurrencyAPIProtocol]) {
        self.apiList = apiList
        for i in 0...apiList.count - 1 {
            self.apiList[i].delegate = self
        }
    }
}

extension CurrencyAPIHelper {
    func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {
        var apiIndex = 0
        
        if let oldRequestId = requestId, let oldRequest = requestDictionary[oldRequestId] {
            apiIndex = oldRequest.apiIndex + 1
        }
        
        let newRequestId = createExchangeValuesRequest(apiIndex: apiIndex, symbolList: symbolList)
        self.apiList[apiIndex].getExchangeValues(currencyCode: currencyCode, symbolList: symbolList, requestId: newRequestId)
    }
    
    func getCurrencyList(requestId: String?) {
        var apiIndex = 0
        
        if let oldRequestId = requestId, let oldRequest = requestDictionary[oldRequestId] {
            apiIndex = oldRequest.apiIndex + 1
        }
        
        let newRequestId = createCurrencyRequest(apiIndex: apiIndex)
        self.apiList[apiIndex].getCurrencyList(requestId: newRequestId)
    }
    
    private func createCurrencyRequest(apiIndex: Int) -> String {
        let request = RequestInformation(apiIndex: apiIndex, symbolList: nil)
        let newRequestId = UUID().uuidString
        requestDictionary[newRequestId] = request
        return newRequestId
    }
    
    private func createExchangeValuesRequest(apiIndex: Int, symbolList: [String]) -> String {
        let request = RequestInformation(apiIndex: apiIndex, symbolList: symbolList)
        let newRequestId = UUID().uuidString
        requestDictionary[newRequestId] = request
        return newRequestId
    }
}

extension CurrencyAPIHelper: CurrencyAPIDataSource {
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>, requestId: String?) {
        if let currentRequestId = requestId, let currentRequest = requestDictionary[currentRequestId] {
            if (exchangeValues.count > 0 || currentRequest.apiIndex == apiList.count - 1) {
                print("Exchange values loaded")
                let retrievedApi = self.apiList[currentRequest.apiIndex]
                
                if !retrievedApi.isCache {
                    self.apiList.forEach { api in
                        api.setCurrencyExchangeValueCache(baseCurrency: baseCurrency, exchangeValues: exchangeValues, symbolList: currentRequest.symbolList!, expiresIn: 600)
                    }
                }
                
                self.delegate?.exchangeValuesLoaded(baseCurrency: baseCurrency, exchangeValues: exchangeValues, requestId: nil)
            } else {
                self.getExchangeValues(currencyCode: baseCurrency, symbolList: currentRequest.symbolList!, requestId: currentRequestId)
            }
        }
    }
    
    func currencyListRetrieved(currencyList: [Currency], requestId: String?) {
        if let currentRequestId = requestId, let currentRequest = requestDictionary[currentRequestId] {
            if (currencyList.count > 0 || currentRequest.apiIndex == apiList.count - 1) {
                print("Currency list loaded")
                let retrievedApi = self.apiList[currentRequest.apiIndex]
                
                if !retrievedApi.isCache {
                    self.apiList.forEach { api in
                        api.setCurrencyListCache(currencyArray: currencyList, expiresIn: 600)
                    }
                    
                }
                
                self.delegate?.currencyListRetrieved(currencyList: currencyList, requestId: nil)
            } else {
                self.getCurrencyList(requestId: currentRequestId)
            }
        }
    }
}

