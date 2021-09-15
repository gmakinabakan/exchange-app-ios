# Currencies

This package implements the currency screens.

## DependencyObject

### CurrenciesDependencyObject

  This class needs to be instantiated from the application that uses this package and supplemented as an environment object.

    public final class CurrenciesDependencyObject: ObservableObject, DataTransferProtocol {
        public var uniqueDataKey: String?
        public var apiList: [CurrencyAPIProtocol]
    }

*uniqueDataKey* is the key that is being used to transfer the data in key-value storage. *apiList* is the list of currency APIs that conforms to protocol CurrencyAPIProtocol defined in CurrencyAPIBase package.

## Model

### CurrencyProtocol

This is an internal protocol that helps the asynchronous comminication between the CurrencyHelper and the views.

    protocol CurrencyProtocol {
        func randomCurrencySelected(currency: Currency, exchangeValue: Double)
        func currencyListRetrieved(currencyList: [Currency])
    }

## Helper

### CurrencyHelper

This internal class implements the business logic of the Currencies package. Currently the business logic is mainly data loading. However, as more business logic arrives, this should be the place to implement.

### CurrencyAPIHelper

This internal class manages the logic of retrieving data from the Currency API list. In our Exchange App example there are two APIs. Currently this class only supports FIFO which means, it tries to retrieve the data from the first element of the array until the end. The first API that returns a valid response terminates this search and the data is returned. In the future there might be other approaches like; random selection or return from the quickest API. All this logic needs to be implemented here.

## Views

### CurrencyListView

This is the view that implements the currency list with a ListView.

### CurrencyRow

This is the view that implements the individual currency row that is used in Currency List View.

### CurrencyDetailView

This is the view that implements the currency detail screen.






Currencies

This package implements the currency screens.

DependencyObject

CurrenciesDependencyObject

This class needs to be instantiated from the application that uses this package and supplemented as an environment object.

public final class CurrenciesDependencyObject: ObservableObject, DataTransferProtocol {
    public var uniqueDataKey: String?
    public var apiList: [CurrencyAPIProtocol]
}
uniqueDataKey is the key that is being used to transfer the data in key-value storage. apiList is the list of currency APIs that conforms to protocol CurrencyAPIProtocol defined in CurrencyAPIBase package.

Model

CurrencyProtocol

This is an internal protocol that helps the asynchronous comminication between the CurrencyHelper and the views.

protocol CurrencyProtocol {
    func randomCurrencySelected(currency: Currency, exchangeValue: Double)
    func currencyListRetrieved(currencyList: [Currency])
}
Helper

CurrencyHelper

This internal class implements the business logic of the Currencies package. Currently the business logic is mainly data loading. However, as more business logic arrives, this should be the place to implement.

CurrencyAPIHelper

This internal class manages the logic of retrieving data from the Currency API list. In our Exchange App example there are two APIs. Currently this class only supports FIFO which means, it tries to retrieve the data from the first element of the array until the end. The first API that returns a valid response terminates this search and the data is returned. In the future there might be other approaches like; random selection or return from the quickest API. All this logic needs to be implemented here.

Views

CurrencyListView

This is the view that implements the currency list with a ListView.

CurrencyRow

This is the view that implements the individual currency row that is used in Currency List View.

CurrencyDetailView

This is the view that implements the currency detail screen.

Markdown 2030 bytes 283 words 52 lines Ln 48, Col 96 HTML 1652 characters 271 words 29 paragraphs
