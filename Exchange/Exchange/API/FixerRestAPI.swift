//
//  FixerRestAPI.swift
//  Exchange
//
//  Created by Gun Makinabakan on 8.09.2021.
//

import Foundation

protocol CurrencyDataSource {
    func exchangeValuesLoaded(baseCurrency:String, exchangeValues: Dictionary<String,Double>)
}

class FixerRestAPI {
    private let SDKKey = "4a0512ccab44d604643710f29c88dd49"
    var delegate: CurrencyDataSource?
    
    public func getExchangeValues(currencyCode: String, symbolList: [String]) {
        let url = URL(string: "https://data.fixer.io/api/latest?access_key=\(SDKKey)&base=\(currencyCode)&symbols=\(symbolList.joined(separator: ","))")!
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
}

struct FixerResponse: Codable, Hashable {
    var success: Bool
    var timestamp: Int
    var base: String
    var date: String
    var rates: Dictionary<String, Double>
}
