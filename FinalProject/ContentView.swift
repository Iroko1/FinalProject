//
//  ContentView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 4/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var baseCurrency: String = ""
    @StateObject private var viewModel: CurrencyViewModel = .init()
    var body: some View {
        
        VStack {
            
            
            HStack {
                
            }
            Text("USD to JPY")
            TextField("base currency", text: $baseCurrency)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250, height: 50)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
