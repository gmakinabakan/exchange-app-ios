
# FixerAPI
**!!!Warning: This package includes Fixer API SDK key in human readable format. This is a really big security problem in a real life production project. This key either needs to reside in a decrypted file that can only be encrpyted during the CD process with the keys embedded in the CD platform. Another option would be using environment variables that would be injected during CD. For the sake of simplicity of this project, the key resides in settings file. The key has a request limit on it and will be deprecated after the project serves its value.**

  This package implement CurrencyAPIBase with the help of Fixer.io API.
## Model
These are internal models that helps to receive data back from the Fixer.io API

### FixerLatestResponse

Response that receives back exhange rates from the Fixer latest API. An example of the request would be (http://data.fixer.io/api/latest?access_key=4a0512ccab44d604643710f29c88dd49&base=GBP)

### FixerListReponse
Response that receives back list of supported currencies. An example of the request would be (http://data.fixer.io/api/symbols?access_key=4a0512ccab44d604643710f29c88dd49)

## Settings

### FixerAPISettings

These are internal static settings, the Base URL for the API and the SDK key of the API (Please read the top of this documentation about the warning how this key is stored for this project).


## API Implementation

### FixerRestAPI
#### CurrencyAPIProtocol
##### public func getCurrencyList(requestId: String?)
This function retrieves the currency data from the Fixer API and returns back a list of currency structs through the delegate. The API returns the Currency Code and the long name for this currency code like *"CHF": "Swiss Franc"*. However the project still needs extra information like flag and the local currency symbol and formatting Bothe the flag and the local formatting requires a country code. The first two letters of currency code is actually the two letter country code that we need. Therefore in this function, I get the first two letters and then get the emoji flag with the *private func flag(country:String) -> String* function.

We also need to find the localization that represents the country code. There is long list of supported localization identifiers available in iOS. I get the list of those with *Locale.availableIdentifiers* and find the matching localization with the country code I have. Only localizations with "_" charachter successfully returns the currency synbol for that country. So my code searches for such a localization and returns the first localization code that fits into this category. This code is being used by the package that displays the currency on the screen.

##### public func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?)
This function retrieves the exchange values for a given currency code and symbol list and returns it using its delegate.

#### APIBaseProtocol
##### public func initialCall()
FixerAPI also supports APIBaseProtocol and implements the *initialCall()* function. The implementation detail is same with the *getCurrencyList* function mentioned above. Any package that wants to get an initial data from this API will receive the currency list in *Data* type

## Further Discussion
### Localization and Country Flag Determination Code
It is really valid to discuss that this piece of code belongs to the API implementation. One idea might be that these belong to the Currencies package. API should only return the currency code, name and should leave the rest of the flag and localization implementation to the currencies package itself. However another discussion might be using cache. If we push the flag and localization impelentation detail to the Currencies package, any caching mechanism that implements Currency Base API will not be caching those values and those values needs to be calculated from scratch with each currency list call. This discussion is still valid if we were implementing the server side of this project. Should we calculate the flag and localization in the server side or leave it to the client.
