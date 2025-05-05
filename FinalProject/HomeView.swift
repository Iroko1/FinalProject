//
//  HomeView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: CurrencyViewModel
//    @StateObject var viewModel: CurrencyViewModel
    @State private var selectedCurrency: Currency?
    @State private var amount: String = ""
    @State private var fromCurrency: Currency?
    @State private var toCurrency: Currency?
    
    
    var body: some View {
        VStack {
            if viewModel.currencies.isEmpty {
                ProgressView("Loading currencies...")
            } else {
                HStack {
                    HStack() {
                        Text("From:")
                            .font(.caption)
                        Picker("From", selection: $fromCurrency) {
                            Text("Choose").tag(nil as Currency?)
                            ForEach(viewModel.currencies, id: \.code) { currency in
                                Text(currency.code).tag(currency as Currency?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    }

//                    Spacer()

                    HStack() {
                        Text("To:")
                            .font(.caption)
                        Picker("To", selection: $toCurrency) {
                            Text("Choose").tag(nil as Currency?)
                            ForEach(viewModel.currencies, id: \.code) { currency in
                                Text(currency.code).tag(currency as Currency?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                

                Button("Convert") {
                    if let from = viewModel.fromCurrency?.code,
                       let to = viewModel.toCurrency?.code,
                       let amount = Double(viewModel.amountToConvert) {
                        
                        viewModel.convertCurrency(from: from, to: to, amount: amount) { result in
                            DispatchQueue.main.async {
                                viewModel.convertedAmount = result
                            }
                        }
                    }
                }
                .disabled(viewModel.fromCurrency == nil ||
                          viewModel.toCurrency == nil ||
                          Double(viewModel.amountToConvert) == nil)
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(8)
                
                
                
            }
            
            Spacer()
            
            NavigationLink("View History", destination: HistoryView())
                .padding(.top)
            
        }
        .padding()
        .navigationTitle(Text("Currency Converter"))
    }
}

