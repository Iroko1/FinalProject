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
    
    init() {
        loadCurrencies()
    }
    
    func convertCurrency(from: String, to: String, amount: Double, completion: @escaping (Double) -> Void) {
        let urlString = "https://api.fxratesapi.com/latest?base=\(from)&currencies=\(to)&places=2&amount=\(amount)&format=json&api_key=fxr_live_d0695d27f108e66dde6dbaf5aa597c9d4173"
        
        guard let url = URL(string: urlString) else {
//            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Conversion API error:", error)
//                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
//                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ConversionResponse.self, from: data)
                let converted = result.rates[to] ?? 0
                completion(converted)
            } catch {
                print("Decoding error:", error)
//                completion(nil)
            }
        }.resume()
        
    }
    
    func loadCurrencies() {
        guard let url = URL(string: "https://api.fxratesapi.com/currencies") else { return }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching currencies: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedDict = try JSONDecoder().decode([String: Currency].self, from: data)
                let currencyList = Array(decodedDict.values).sorted { $0.code < $1.code }
                DispatchQueue.main.async {
                    self.currencies = currencyList
                }
            } catch {
                print("Decoding error: \(error)")
            }
            
        }
        
        dataTask.resume()
    }
    
}
