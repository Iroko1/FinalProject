//
//  MainView.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 5/5/25.
//
import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @State private var isFavorite = false
    @StateObject var viewModel = CurrencyViewModel()

    var body: some View {
            TabView(selection: $selectedTab) {
                HomeView(viewModel: viewModel, selectedTab: $selectedTab, isFavorite: $isFavorite)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)

                ResultView(viewModel: viewModel, selectedTab: $selectedTab, isFavorite: $isFavorite)
                    .tabItem {
                        Label("Result", systemImage: "arrow.left.arrow.right")
                    }
                    .tag(1)

                HistoryView(viewModel: viewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "clock")
                    }
                    .tag(2)
            }
        }
}
