//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 4/28/25.
//

import SwiftUI

@main
struct FinalProjectApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(viewModel: CurrencyViewModel())
            }
        }
    }
}
