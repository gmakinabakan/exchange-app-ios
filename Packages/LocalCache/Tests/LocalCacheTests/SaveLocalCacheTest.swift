//
//  ExchangeTests.swift
//  ExchangeTests
//
//  Created by Gun Makinabakan on 7.09.2021.
//

import XCTest
import CurrencyAPIBase
@testable import LocalCache

class SaveLocalCacheTest: XCTestCase {
    
    var fileURLToDelete: URL?
    let fileManager = FileManager.default
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fileURLToDelete = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        if let fileURL = fileURLToDelete {
            do {
                print("Removing file \(fileURL)")
                try fileManager.removeItem(at: fileURL)
            } catch let error{
                print(error)
            }
        }
    }

    func testSavingLocalCacheFileForCurrencyList() {
        //Given
        let currency1 = Currency(id: "1", flag: "TR", abbreviation: "TRY", name: "Turkish Lira", localeString: "T")
        let currency2 = Currency(id: "1", flag: "GR", abbreviation: "GRY", name: "Greek Euro", localeString: "G")
        let currencyArray = [currency1, currency2]
        let currencyLocalCache = CurrencyLocalCache()
        let expiresIn = 10.0
        
        //When
        currencyLocalCache.setCurrencyListCache(currencyArray: currencyArray, expiresIn: expiresIn)
        
        //What
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let targetURL = tempDirectoryURL.appendingPathComponent("CurrencyArray.data")
        fileURLToDelete = targetURL
        let data = try! Data(contentsOf: targetURL)
        XCTAssert(data.count > 0)
        
        let decoder = JSONDecoder()
        let cachedData = try! decoder.decode(CachedData.self, from: data)
        XCTAssert(cachedData.data.count > 0)
        
        let savedCurrencyArray = try! decoder.decode([Currency].self, from: cachedData.data)
        XCTAssertEqual(savedCurrencyArray, currencyArray)
        
        let timestamp = NSDate().timeIntervalSince1970
        XCTAssert(cachedData.expirationTimestamp - timestamp > expiresIn - 1)
        XCTAssert(cachedData.expirationTimestamp - timestamp < expiresIn)
    }
    
    
    func testSavingLocalCacheFileForExchangeValues() {
        //Given
        var exchangeValues = Dictionary<String, Double>()
        exchangeValues["TRY"] = 3.5
        exchangeValues["USD"] = 4.0
        let symbolList = ["NZD","BIF","LKR","INR"]
        let currencyLocalCache = CurrencyLocalCache()
        let baseCurrency = "BSE"
        
        //When
        currencyLocalCache.setCurrencyExchangeValueCache(baseCurrency: baseCurrency, exchangeValues: exchangeValues, symbolList: symbolList, expiresIn: 300)
        
        //What
        var hasher = Hasher()
        hasher.combine(symbolList)
        let hash = hasher.finalize()
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let targetURL = tempDirectoryURL.appendingPathComponent("\(baseCurrency)_\(hash)_ExchangeValue.data")
        fileURLToDelete = targetURL
        let data = try! Data(contentsOf: targetURL)
        XCTAssert(data.count > 0)
    }

}
