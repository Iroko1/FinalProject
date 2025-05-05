//
//  MainView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//
import SwiftUI

struct MainView: View {
    @StateObject var viewModel = CurrencyViewModel()

    var body: some View {
        TabView {
            HomeView(viewModel: viewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ResultTabView(viewModel: viewModel)
                .tabItem {
                    Label("Convert", systemImage: "arrow.left.arrow.right")
                }

            HistoryView(viewModel: viewModel)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
    }
}
