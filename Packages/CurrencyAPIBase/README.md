
# CurrencyAPIBase

This package is designed to be a blueprint for any package that will implement an API that retrieves currency data and also any package that uses currency data.

## Model

### Currency

**id:** Unique Id of the currency.
**flag:** Emoji flag of the country that is using this currency.
**abbreviation:** The abbreviation of the currency
**name:** Human readable long name of the curreny
**localeString:** This is the string that represents the locale of the country that is using this currency (e.g. en-US).

## Protocols
### CurrencyAPIProtocol

This protocol needs to be implemented by any API that would retrieve currency data for the caller.

    public protocol CurrencyAPIProtocol {
        var delegate: CurrencyAPIDataSource? {get  set}
        func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?)
        func getCurrencyList(requestId: String?)
        func setCurrencyListCache(currencyArray: [Currency], expiresIn: Double)
        func setCurrencyExchangeValueCache(baseCurrency: String, exchangeValues: Dictionary<String, Double>, symbolList: [String], expiresIn: Double)
    }

####  var delegate: CurrencyAPIDataSource? {get set}
The delegate that the retrieved data will be sent.

#### func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?)
Implementer of this function should get the exhange values for a currency code (base currency), with the given symbol list. If the request and the answer need to be tracked, requestId should be given to the function.

#### func getCurrencyList(requestId: String?)
Implementer of this function should retrieve the list of currencies. If the request and the answer need to be tracked, requestId should be given to the function.

#### func setCurrencyListCache(currencyArray: [Currency], expiresIn: Double)
If the implementer has a caching mechanism, this function needs to be implemented in a way that the currency list data should be cached for the given duration (seconds)

#### func setCurrencyExchangeValueCache(baseCurrency: String, exchangeValues: Dictionary<String, Double>, symbolList: [String], expiresIn: Double)
If the implementer has a caching mechanism, this function needs to be implemented in a way that the exchange values data should be cached for the given duration (seconds)

### CurrencyAPIDataSource

Code that uses Currency API to retrieve currency data asynchronously needs to implement this protocol. If requestId is sent with the request, it will be received back from the data source.

    public protocol CurrencyAPIDataSource {
        func exchangeValuesLoaded(baseCurrency:String, exchangeValues: Dictionary<String,Double>, requestId: String?)
        func currencyListRetrieved(currencyList: [Currency], requestId: String?)
    }

