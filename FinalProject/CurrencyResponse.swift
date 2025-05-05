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

struct Currency: Decodable {
    let code: String
    let name: String
    let decimal_digits: Int
    let name_Plural: String
    let rounding: Int
    let symbol: String
    let symbol_native: String
}

