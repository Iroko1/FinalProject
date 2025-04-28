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
