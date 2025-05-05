//
//  ResultView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: CurrencyViewModel
    @State private var isLoading = true
    @State private var hasError = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoading {
                    ProgressView("Converting...")
                        .onAppear {
                            performConversion()
                        }
                } else if hasError {
                    Text("Conversion failed. Please try again.")
                        .foregroundColor(.red)
                } else if let converted = viewModel.convertedAmount,
                          let rate = viewModel.conversionRate,
                          let date = viewModel.conversionDate {
                    
                    Text("Conversion Result")
                        .font(.title2)
                        .bold()
                    
                    Text("\(viewModel.amountToConvert) \(viewModel.fromCurrency?.code ?? "") = \(String(format: "%.2f", converted)) \(viewModel.toCurrency?.code ?? "")")
                        .font(.title3)
                        .padding(.bottom)

                    Text("Exchange Rate: \(rate)")
                    Text("Date: \(date)")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    
                    Button("Save to History") {
                        viewModel.saveCurrentConversionToHistory()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Text("No conversion data available.")
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Result")
        }
    }

    func performConversion() {
        guard let from = viewModel.fromCurrency?.code,
              let to = viewModel.toCurrency?.code,
              let amount = Double(viewModel.amountToConvert) else {
            self.isLoading = false
            self.hasError = true
            return
        }

        viewModel.convertCurrency(from: from, to: to, amount: amount) { success in
            DispatchQueue.main.async {
                self.isLoading = false
                self.hasError = !success
            }
        }
    }
}
