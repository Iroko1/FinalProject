//
//  CurrencyResponse.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 4/28/25.
//

import SwiftUI
import Foundation

struct CurrencyResponse: Codable {
    let currencies: [String: Currency]
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let raw = try container.decode([String: Currency].self)
//        self.currencies = raw
//    }
}

struct Currency: Codable, Hashable, Identifiable {
    var id: String { code }
    let code: String
    let name: String
    let decimal_digits: Int
    let name_plural: String
    let rounding: Int
    let symbol: String
    let symbol_native: String
}

struct ConversionResponse: Codable, Hashable {
    let success: Bool
    let base: String?
    let date: String?
    let rates: [String: Double]
}

struct errorResponse: Codable, Hashable {
    let success: Bool
    let error: String?
    let description: String?
}

struct ConversionHistoryItem: Identifiable {
    let id = UUID()
    let fromCurrency: String
    let toCurrency: String
    let amount: Double
    let rate: Double
    let result: Double
    let date: String
}
