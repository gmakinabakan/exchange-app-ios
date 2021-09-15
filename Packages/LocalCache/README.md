
# LocalCache
This package implements CurrencyAPIBase and serves as a cache. It saves the data to the temporary folder preventing the danger of enlarging application size with time.
## Model

### CachedData

    struct CachedData: Codable, Hashable {
        var expirationTimestamp: Double
        var data: Data
    }

This internal struct is used for writing and reading cached data to/from the file.

## API Implementation
#### CurrencyLocalCache

This is the implementation of CurrencyAPIProtocol.

##### public func getCurrencyList(requestId: String?)
Returns the cached currency list if the cache exists and has not been expired. Returns an empty currency array otherwise.

##### public func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?)
Returns the cached exchange values if the cache exists and has not been expired. Returns an empty exhange value dictionary otherwise.

##### public func setCurrencyListCache(currencyArray: [Currency], expiresIn: Double)
This saves the currency list as a file with the given expiration duration in seconds. The filename is *"CurrencyArray.data"*

##### public func setCurrencyExchangeValueCache(baseCurrency: String, exchangeValues: Dictionary<String, Double>, symbolList: [String], expiresIn: Double)
This saves the exchange value list as a file with the given expiration duration in seconds. The filename is *"(baseCurrency)_(symbolListHash)_ExchangeValue.data"*

## Tests

### RetrieveLocalCacheTest
These tests are aimed to test if the cache is retrieved properly from the API. Since the API is asynchronous, *expectation* is used to properly test the return values. The name of the test functions are;

 - *testEmptyCacheForCurrencyList()*
 - *testExpiringCacheForCurrencyList()*
 - *testGetCurrecyListWithCache()*
 - *testGetCurrecyListWithNoRequestId()*
 - *testEmptyCacheForExchangeValues()*
 - *testExpiringCacheForExchangeValues()*
 - *testExchangeValuesWithCache()*
 - *testGetExchangeValuesWithNoRequestId()*
 
 ### SaveLocalCacheTest
 These tests are aimed to test the file writing and reading functionalities specifically. Each functions tests the writing and reading cycles entirely. The name of the test functions are;

  - *testSavingLocalCacheFileForCurrencyList()*
 - *testSavingLocalCacheFileForExchangeValues()*
