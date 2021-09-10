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
    
    func setCache() {
    }
}
