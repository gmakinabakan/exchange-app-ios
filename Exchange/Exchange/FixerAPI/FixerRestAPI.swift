//
//  FixerRestAPI.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation

class FixerRestAPI: CurrencyAPIProtocol {
    var delegate: CurrencyAPIDataSource?
    var baseDelegate: DataSourceBaseProtocol?
    
    public func getExchangeValues(currencyCode: String, symbolList: [String], requestId: String?) {
        print("Retrieving exchange values from Fixer API")
        let url = URL(string: "\(FixerAPISettings.BaseURL)/latest?access_key=\(FixerAPISettings.SDKKey)&base=\(currencyCode)&symbols=\(symbolList.joined(separator: ","))")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let fixerResponse = try! decoder.decode(FixerResponse.self, from: data)
            DispatchQueue.main.async {
                self.delegate?.exchangeValuesLoaded(baseCurrency: currencyCode, exchangeValues: fixerResponse.rates, requestId: requestId)
            }
        }

        task.resume()
    }
    
    public func getCurrencyList(requestId: String?) {
        print("Retrieving currency list from Fixer API")
        let url = URL(string: "https://data.fixer.io/api/symbols?access_key=\(FixerAPISettings.SDKKey)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let currencyArray = self.getCurrencyListFromAPIData(data: data)
            
            DispatchQueue.main.async {
                self.delegate?.currencyListRetrieved(currencyList: currencyArray, requestId: requestId)
            }
        }
        
        task.resume()
    }
    
    private func getCurrencyListFromAPIData(data: Data) -> [Currency] {
        let decoder = JSONDecoder()
        let fixerListResponse = try! decoder.decode(FixerListReponse.self, from: data)
        
        let currencyFormatterAvailable = Array(Locale.availableIdentifiers).filter { word in return word.split(separator: "_").count > 1}
        
        let symbolArray = Array(fixerListResponse.symbols.keys)
        var currencyArray: [Currency] = []
        
        symbolArray.forEach({
            let countryCode = String(String($0).prefix(2))
            if let formatToDisplay = currencyFormatterAvailable.first(where: {$0.hasSuffix("_\(countryCode)")} ) {

                let currency = Currency(id: $0, flag: self.flag(country: String(countryCode)), abbreviation: $0, name: fixerListResponse.symbols[$0]!, localeString: formatToDisplay)
                currencyArray.append(currency)
            }
        })
        return currencyArray
    }
    
    private func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

extension FixerRestAPI: APIBaseProtocol {
    func initialCall() {
        print("Retrieving currency list from Fixer API (Initial API)")
        let url = URL(string: "https://data.fixer.io/api/symbols?access_key=\(FixerAPISettings.SDKKey)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let encoder = JSONEncoder()
            let currencyArray = self.getCurrencyListFromAPIData(data: data)
            let jsonData = try! encoder.encode(currencyArray)

            DispatchQueue.main.async {
                self.baseDelegate?.initialDataRetrieved(data: jsonData)
            }
        }
        
        task.resume()
    }
}

struct FixerListReponse: Codable, Hashable {
    var success: Bool
    var symbols: Dictionary<String, String>
}
