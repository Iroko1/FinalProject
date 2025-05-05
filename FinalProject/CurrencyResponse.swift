//
//  CurrencyResponse.swift
//  FinalProject
//
//  Created by ROTSEVENKOV, MATVEY V. on 4/28/25.
//

import SwiftUI
import Foundation

struct CurrencyResponse: Codable {
    let success: Bool
    let timestamp: Int
    let date: String
    let base: String
    let rates: [String: Double]
}

struct Currency: Decodable, Hashable {
    let code: String
        let name: String
        let decimal_digits: Int
        let name_plural: String
        let rounding: Int
        let symbol: String
        let symbol_native: String
}

struct ConversionResponse: Decodable {
    let success: Bool
    let base: String
    let date: String
    let rates: [String: Double]
}
