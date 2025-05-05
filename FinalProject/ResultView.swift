//
//  ResultView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//

import SwiftUI

struct ResultTabView: View {
//    let amount: Double
//    let fromCurrency: Currency?
//    let toCurrency: Currency?
    @ObservedObject var viewModel: CurrencyViewModel
    
    
//    @State private var convertedAmount: Double?
//    @State private var isLoading = true
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                ProgressView("Converting...")
            } else if let converted = convertedAmount, let to = toCurrency {
                Text("Converted Amount:")
                Text("\(to.symbol) \(converted, specifier: "%.2f")")
                    .font(.title)
            } else {
                Text("Failed to convert.")
            }
        }
        .onAppear {
            if let from = fromCurrency?.code, let to = toCurrency?.code {
                viewModel.convertCurrency(from: from, to: to, amount:amount) { result in
                    DispatchQueue.main.async {
                        self.convertedAmount = result
                        self.isLoading = false
                    }
                }
            }
        }
    }
}


