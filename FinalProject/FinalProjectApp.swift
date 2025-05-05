//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 4/28/25.
//

import SwiftUI

@main
struct FinalProjectApp: App {
    @StateObject private var viewModel = CurrencyViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
