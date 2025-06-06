//
//  HomeView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//
//
//import SwiftUI
//
//struct HomeView: View {
//    @ObservedObject var viewModel: CurrencyViewModel
////    @StateObject var viewModel: CurrencyViewModel
//    @State private var selectedCurrency: Currency?
//    @State private var amount: String = ""
//    @State private var fromCurrency: Currency?
//    @State private var toCurrency: Currency?
//    
//    
//    var body: some View {
//        VStack {
//            if viewModel.currencies.isEmpty {
//                ProgressView("Loading currencies...")
//            } else {
//                HStack {
//                    HStack() {
//                        Text("From:")
//                            .font(.caption)
//                        Picker("From", selection: $fromCurrency) {
//                            Text("Choose").tag(nil as Currency?)
//                            ForEach(viewModel.currencies, id: \.code) { currency in
//                                Text(currency.code).tag(currency as Currency?)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        
//                    }
//
////                    Spacer()
//
//                    HStack() {
//                        Text("To:")
//                            .font(.caption)
//                        Picker("To", selection: $toCurrency) {
//                            Text("Choose").tag(nil as Currency?)
//                            ForEach(viewModel.currencies, id: \.code) { currency in
//                                Text(currency.code).tag(currency as Currency?)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        
//                    }
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.horizontal)
//                
//                
//                TextField("Amount", text: $amount)
//                    .keyboardType(.decimalPad)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//
//                Button("Convert") {
//                    if let from = viewModel.fromCurrency?.code,
//                       let to = viewModel.toCurrency?.code,
//                       let amount = Double(viewModel.amountToConvert) {
//                        
//                        viewModel.convertCurrency(from: from, to: to, amount: amount) { result in
//                            DispatchQueue.main.async {
//                                viewModel.convertedAmount = result
//                            }
//                        }
//                    }
//                }
//                .disabled(viewModel.fromCurrency == nil ||
//                          viewModel.toCurrency == nil ||
//                          Double(viewModel.amountToConvert) == nil)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//
//                
//                
//                
//            }
//            
//            Spacer()
//            
//            NavigationLink("View History", destination: HistoryView())
//                .padding(.top)
//            
//        }
//        .padding()
//        .navigationTitle(Text("Currency Converter"))
//    }
//}
//


import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: CurrencyViewModel
    @Binding var selectedTab: Int
    @Binding var isFavorite: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("From:")
                        Picker("From", selection: $viewModel.fromCurrency) {
                            Text("USD").tag(nil as Currency?)
                            ForEach(viewModel.currencies, id: \.code) { currency in
                                Text("\(currency.code) - \(currency.name)").tag(currency as Currency?)
                            }
                            
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    VStack(alignment: .leading) {
                        Text("To:")
                        Picker("To", selection: $viewModel.toCurrency) {
                            Text("JPY").tag(nil as Currency?)
                            ForEach(viewModel.currencies, id: \.code) { currency in
                                Text("\(currency.code) - \(currency.name)").tag(currency as Currency?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding(.horizontal)
                
                TextField("Enter amount", text: $viewModel.amountToConvert)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Convert") {
                    if let from = viewModel.fromCurrency?.code,
                       let to = viewModel.toCurrency?.code,
                       let amount = Double(viewModel.amountToConvert) {
                        viewModel.convertCurrency(from: from, to: to, amount: amount) { success in
                            if success {
                                selectedTab = 1
                                isFavorite = false
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Currency Converter")
        }
    }
}

