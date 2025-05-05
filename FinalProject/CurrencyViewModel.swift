//
//  CurrencyViewModel.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//

import SwiftUI
//&api_key=fxr_live_d0695d27f108e66dde6dbaf5aa597c9d4173
class CurrencyViewModel: ObservableObject {
    @Published var currencies: [Currency] = []
    @Published var fromCurrency: Currency?
    @Published var toCurrency: Currency?
    @Published var amountToConvert: String = ""
    @Published var convertedAmount: Double?
    @Published var conversionRate: Double?
    @Published var conversionDate: String?
    @Published var history: [ConversionHistoryItem] = []
    
    
    init() {
        loadCurrencies()
    }
    
    
    func saveCurrentConversionToHistory() {
        guard let from = fromCurrency?.code,
              let to = toCurrency?.code,
              let rate = conversionRate,
              let result = convertedAmount,
              let date = conversionDate,
              let amount = Double(amountToConvert) else {
            return
        }
        
        let item = ConversionHistoryItem(fromCurrency: from, toCurrency: to, amount: amount, rate: rate, result: result, date: date)
        
        history.insert(item, at: 0)
    }
    
    
    
    
    func convertCurrency(from: String, to: String, amount: Double, completion: @escaping (Bool) -> Void) {
        let urlString = "https://api.fxratesapi.com/convert?from=\(from)&to=\(to)&amount=\(amount)"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            do {
                let result = try JSONDecoder().decode(ConversionResponse.self, from: data)
                DispatchQueue.main.async {
                    if let rate = result.rates[to] {
                        self.conversionRate = rate
                        self.convertedAmount = rate * amount
                        self.conversionDate = result.date
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            } catch {
                print("Conversion error: \(error)")
                completion(false)
            }
        }.resume()
    }

    
    func loadCurrencies() {
        guard let url = URL(string: "https://api.fxratesapi.com/currencies") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode([String: Currency].self, from: data)
                    DispatchQueue.main.async {
                        self.currencies = response.values.sorted { $0.code < $1.code }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
        
    }
    //
    //        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    //        request.httpMethod = "GET"
    //
    //        let session = URLSession.shared
    //        let dataTask = session.dataTask(with: request) { data, response, error in
    //            if let error = error {
    //                print("Error fetching currencies: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let data = data else {
    //                print("No data received")
    //                return
    //            }
    //
    //            do {
    //                let decodedDict = try JSONDecoder().decode([String: Currency].self, from: data)
    //                let currencyList = Array(decodedDict.values).sorted { $0.code < $1.code }
    //                DispatchQueue.main.async {
    //                    self.currencies = currencyList
    //                }
    //            } catch {
    //                print("Decoding error: \(error)")
    //            }
    //
    //        }
    //
    //        dataTask.resume()
    //    }
    //
    //}
}
