//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Dao Anh Phuc on 29/10/24.
//

import Combine
import Foundation

@MainActor
class CurrencyConverterViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var baseCurrency: String = "EUR"
    @Published var targetCurrency: String = "VND"
    
    @Published var decimalPlaces: Int = 2
    @Published var convertedAmount: String = ""
    @Published var exchangeRates: [String: Double] = [:]

    @Published var symbols: [String: String] = [:]

    @Published var isLoading: Bool = false
    @Published var isLoadingSymbols: Bool = false
    @Published var isLoadingRates: Bool = false
    @Published var errorMessage: String? = nil
    
    private let apiKey = "c133c298e69be24ad8f8b9f939547577"
    private let baseAPI = "https://api.exchangeratesapi.io/v1"
    
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        Task {
            isLoading = true
            await fetchSymbols()
            await fetchExchangeRates()
            isLoading = false
        }
    }

    func refreshData() async {
        await fetchSymbols()
        await fetchExchangeRates()
    }

    func fetchSymbols() async {
        isLoadingSymbols = true
        errorMessage = nil

        let urlString = "\(baseAPI)/symbols?access_key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(SymbolsResponse.self, from: data)

            if result.success {
                symbols = result.symbols
            } else {
                errorMessage = "Failed to fetch symbols"
            }
        } catch {
            errorMessage = "Failed to fetch symbols: \(error.localizedDescription)"
        }

        isLoadingSymbols = false
    }
    
    func fetchExchangeRates() async {
        isLoadingRates = true
        errorMessage = nil
        
        let urlString = "\(baseAPI)/latest?access_key=\(apiKey)&base=\(baseCurrency)"
        
        //error handling for wrong URL
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let result = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
            
            exchangeRates = result.conversionRates
        } catch {
            errorMessage = "Failed to fetch rates: \(error.localizedDescription)"
        }
        
        isLoadingRates = false
    }
    
    func convertCurrency () {
        guard let amountValue = Double(amount), amountValue > 0 else {
            errorMessage = "Plesae enter a valid numeric amount."
            return
        }
        
        if amountValue > 0 {
            errorMessage = nil
        }
        
        
        guard baseCurrency != targetCurrency else {
            errorMessage = "Please choose two different currencies"
            return
        }
        
        guard let baseRate = exchangeRates[baseCurrency],
              let targetRate = exchangeRates[targetCurrency] else {
            errorMessage = "Convert rate unavailable"
            return
        }
        
        let rate = targetRate / baseRate
        let result = amountValue * rate
        
        convertedAmount = String(format: "%.\(decimalPlaces)f", result)
    }
}
