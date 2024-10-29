//
//  ExchangeRates.swift
//  CurrencyConverter
//
//  Created by Dao Anh Phuc on 29/10/24.
//

import Foundation

struct ExchangeRate: Codable {
    let currency: String
    let rate: Double
}

struct SymbolsResponse: Codable {
    let success: Bool
    let symbols: [String: String]
}

struct ExchangeRateResponse: Codable {
    let conversionRates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case conversionRates = "rates"
    }
}
