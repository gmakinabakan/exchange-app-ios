//
//  FixerRestAPI.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation

class FixerRestAPI: CurrencyAPIProtocol {
    
    var delegate: CurrencyAPIDataSource?
    
    public func getExchangeValues(currencyCode: String, symbolList: [String]) {
        let url = URL(string: "\(FixerAPISettings.BaseURL)/latest?access_key=\(FixerAPISettings.SDKKey)&base=\(currencyCode)&symbols=\(symbolList.joined(separator: ","))")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let fixerResponse = try! decoder.decode(FixerResponse.self, from: data)
            DispatchQueue.main.async {
                self.delegate?.exchangeValuesLoaded(baseCurrency: currencyCode, exchangeValues: fixerResponse.rates)
            }
        }

        task.resume()
    }
    
    public func getCurrencyList() {
        let url = URL(string: "https://data.fixer.io/api/symbols?access_key=\(FixerAPISettings.SDKKey)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
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
            DispatchQueue.main.async {
                self.delegate?.currencyListRetrieved(currencyList: currencyArray)
            }
        }
        
        task.resume()
    }
    
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func setCache() {
    }
}

struct FixerListReponse: Codable, Hashable {
    var success: Bool
    var symbols: Dictionary<String, String>
}
