//
//  HomeView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: CurrencyViewModel
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
                

                
                
                NavigationLink(
                    destination: ResultView(
                        amount: Double(amount) ?? 0.0,
                        fromCurrency: fromCurrency,
                        toCurrency: toCurrency,
                        viewModel: viewModel
                    )
                ) {
                    Text("Convert")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(fromCurrency == nil || toCurrency == nil || Double(amount) == nil)
                .padding(.top)
                
            }
            
            Spacer()
            
            NavigationLink("View History", destination: HistoryView())
                .padding(.top)
            
        }
        .padding()
        .navigationTitle(Text("Currency Converter"))
    }
}

