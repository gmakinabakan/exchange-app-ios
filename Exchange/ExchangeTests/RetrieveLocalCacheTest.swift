//
//  RetrieveLocalCacheTest.swift
//  ExchangeTests
//
//  Created by Gun Makinabakan on 14.09.2021.
//

import XCTest
@testable import Exchange

class RetrieveLocalCacheTest: XCTestCase, CurrencyAPIDataSource {

    var expectation: XCTestExpectation?
    var retrievedCurrencyList: [Currency]?
    var retrievedRequestId: String?
    var retrievedBaseCurrency: String?
    var retrievedExchangeValues: Dictionary<String, Double>?
    var fileURLToDelete: URL?
    
    let fileManager = FileManager.default
    let symbolList = ["NZD","BIF","LKR","INR"]
    let baseCurrency = "BSE"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fileURLToDelete = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.retrievedCurrencyList = nil
        self.retrievedRequestId = nil
        self.retrievedBaseCurrency = nil
        self.retrievedExchangeValues = nil
        self.expectation = nil
        
        if let fileURL = fileURLToDelete {
            do {
                print("Removing file \(fileURL)")
                try fileManager.removeItem(at: fileURL)
            } catch let error{
                print(error)
            }
        }
    }

    func testEmptyCacheForCurrencyList() throws {
        //Given
        let currencyLocalCache = CurrencyLocalCache()
        currencyLocalCache.delegate = self
        let requestId = UUID().uuidString
        
        //When
        expectation = expectation(description: "Empty currency list call")
        currencyLocalCache.getCurrencyList(requestId: requestId)
        waitForExpectations(timeout: 2)
        
        //What
        XCTAssertEqual(self.retrievedCurrencyList, [])
        XCTAssertEqual(self.retrievedRequestId,requestId)
    }
    
    func testExpiringCacheForCurrencyList() throws {
        //Given
        let currencyLocalCache = CurrencyLocalCache()
        currencyLocalCache.delegate = self
        let requestId = UUID().uuidString
        let currencyList = createCurrencyList()
        currencyLocalCache.setCurrencyListCache(currencyArray: currencyList, expiresIn: 1)
        self.fileURLToDelete = createTempURL(fileName: "CurrencyArray.data")
        
        //When
        expectation = expectation(description: "Expiring currency list call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            currencyLocalCache.getCurrencyList(requestId: requestId)
        }
        waitForExpectations(timeout: 4)
        
        //What
        XCTAssertEqual(self.retrievedCurrencyList, [])
        XCTAssertEqual(self.retrievedRequestId,requestId)
    }

    func testEmptyCacheForExchangeValues() throws {
        //Given
        let currencyLocalCache = CurrencyLocalCache()
        currencyLocalCache.delegate = self
        let requestId = UUID().uuidString

        //When
        expectation = expectation(description: "Empty exchange values call")
        currencyLocalCache.getExchangeValues(currencyCode: baseCurrency, symbolList: symbolList, requestId: requestId)
        waitForExpectations(timeout: 2)
        
        //What
        XCTAssertEqual(self.retrievedExchangeValues, Dictionary<String, Double>())
        XCTAssertEqual(self.retrievedBaseCurrency, baseCurrency)
        XCTAssertEqual(self.retrievedRequestId, requestId)
    }
    
    func testExpiringCacheForExchangeValues() throws {
        //Given
        let currencyLocalCache = CurrencyLocalCache()
        currencyLocalCache.delegate = self
        let requestId = UUID().uuidString
        currencyLocalCache.setCurrencyExchangeValueCache(baseCurrency: self.baseCurrency, exchangeValues: createExchangeValues(), symbolList: self.symbolList, expiresIn: 1)
        let hash = createHashForSymbolList(symbolList: self.symbolList)
        self.fileURLToDelete = createTempURL(fileName: "\(self.baseCurrency)_\(hash)_ExchangeValue.data")
        
        //When
        expectation = expectation(description: "Expiring exchange values call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            currencyLocalCache.getExchangeValues(currencyCode: self.baseCurrency, symbolList: self.symbolList, requestId: requestId)
        }
        waitForExpectations(timeout: 4)
        
        //What
        XCTAssertEqual(self.retrievedExchangeValues, Dictionary<String, Double>())
        XCTAssertEqual(self.retrievedBaseCurrency, self.baseCurrency)
        XCTAssertEqual(self.retrievedRequestId, requestId)
    }
    
    func currencyListRetrieved(currencyList: [Currency], requestId: String?) {
        self.retrievedCurrencyList = currencyList
        self.retrievedRequestId = requestId
        expectation?.fulfill()
    }
    
    func exchangeValuesLoaded(baseCurrency: String, exchangeValues: Dictionary<String, Double>, requestId: String?) {
        self.retrievedBaseCurrency = baseCurrency
        self.retrievedExchangeValues = exchangeValues
        self.retrievedRequestId = requestId
        expectation?.fulfill()
    }
    
    func createExchangeValues() -> Dictionary<String, Double> {
        var exchangeValues = Dictionary<String, Double>()
        exchangeValues["TRY"] = 3.5
        exchangeValues["USD"] = 4.0
        return exchangeValues
    }
    
    func createCurrencyList() -> [Currency] {
        let currency1 = Currency(id: "1", flag: "TR", abbreviation: "TRY", name: "Turkish Lira", localeString: "T")
        let currency2 = Currency(id: "1", flag: "GR", abbreviation: "GRY", name: "Greek Euro", localeString: "G")
        return [currency1, currency2]
    }
    
    func createTempURL(fileName: String) -> URL {
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        return tempDirectoryURL.appendingPathComponent(fileName)
    }
    
    func createHashForSymbolList(symbolList: [String]) -> Int {
        var hasher = Hasher()
        hasher.combine(object)
        return hasher.finalize()
    }
}
