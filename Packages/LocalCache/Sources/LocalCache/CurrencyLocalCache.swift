//
//  LocalCache.swift
//  Exchange
//
//  Created by Gun Makinabakan on 12.09.2021.
//

import Foundation
import CurrencyAPIBase

public class CurrencyLocalCache: CurrencyAPIProtocol {
    public weak var delegate: CurrencyAPIDataSource?
    
    public init() {}
    
    public func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {
        print("Retrieving exchange from local cache")
        var hasher = Hasher()
        hasher.combine(symbolList)
        let hash = hasher.finalize()
        if let data = readTemporaryFile(fileName: "\(currencyCode)_\(hash)_ExchangeValue.data"){
            let decoder = JSONDecoder()
            
            let exchangeValues = try! decoder.decode(Dictionary<String, Double>.self, from: data)
            self.delegate?.exchangeValuesLoaded(baseCurrency: currencyCode, exchangeValues: exchangeValues, requestId: requestId)
        } else {
            self.delegate?.exchangeValuesLoaded(baseCurrency: currencyCode, exchangeValues: Dictionary<String, Double>(), requestId: requestId)
        }
    }
    
    public func getCurrencyList(requestId: String?) {
        print("Retrieving currency list from local cache")
        if let data = readTemporaryFile(fileName: "CurrencyArray.data"){
            let decoder = JSONDecoder()
            let currencyArray = try! decoder.decode([Currency].self, from: data)
            self.delegate?.currencyListRetrieved(currencyList: currencyArray, requestId: requestId)
        } else {
            self.delegate?.currencyListRetrieved(currencyList: [], requestId: requestId)
        }
    }
    
    public func setCurrencyListCache(currencyArray: [Currency], expiresIn: Double) {
        let encoder = JSONEncoder()
        let currencyArrayData = try! encoder.encode(currencyArray)
        saveTemporaryFile(dataToSave: currencyArrayData, fileName: "CurrencyArray.data", expiresIn: expiresIn)
    }
    
    public func setCurrencyExchangeValueCache(baseCurrency: String, exchangeValues: Dictionary<String, Double>, symbolList: [String], expiresIn: Double) {
        
        var hasher = Hasher()
        hasher.combine(symbolList)
        let hash = hasher.finalize()
        let encoder = JSONEncoder()
        let currencyArrayData = try! encoder.encode(exchangeValues)
        saveTemporaryFile(dataToSave: currencyArrayData, fileName: "\(baseCurrency)_\(hash)_ExchangeValue.data", expiresIn: expiresIn)
    }
    
    private func saveTemporaryFile(dataToSave: Data, fileName: String, expiresIn: Double) {
        print("Saving cache for \(fileName)")
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let targetURL = tempDirectoryURL.appendingPathComponent(fileName)
        
        let timestamp = NSDate().timeIntervalSince1970
        let cachedData = CachedData(expirationTimestamp: timestamp + expiresIn, data: dataToSave)
        let encoder = JSONEncoder()
        let cachedDataToSave = try! encoder.encode(cachedData)
        
        try! cachedDataToSave.write(to: targetURL)
    }
    
    private func readTemporaryFile(fileName: String) -> Data? {
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let targetURL = tempDirectoryURL.appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: targetURL)
            let decoder = JSONDecoder()
            let cachedData = try! decoder.decode(CachedData.self, from: data)
            let timestamp = NSDate().timeIntervalSince1970
            if(cachedData.expirationTimestamp < timestamp) {
                print("Cache expired...")
                return nil
            }
            return cachedData.data
        }
        catch let error {
            print(error)
            return nil
        }
    }
}
