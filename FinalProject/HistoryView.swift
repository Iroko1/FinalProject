//
//  HistoryView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: CurrencyViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.history.isEmpty {
                    Text("No conversions saved yet.")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(viewModel.history) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(item.amount, specifier: "%.2f") \(item.fromCurrency) → \(item.result, specifier: "%.2f") \(item.toCurrency)")
                                .font(.headline)
                            Text("Rate: \(item.rate, specifier: "%.4f") on \(item.date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}


