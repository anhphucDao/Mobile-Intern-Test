//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Dao Anh Phuc on 29/10/24.
//
import XCTest
@testable import CurrencyConverter

@MainActor
final class CurrencyConverterViewModelTests: XCTestCase {
    
    var viewModel: CurrencyConverterViewModel!
    var networkMonitor: NetworkMonitor!
    
    override func setUp() {
        super.setUp()
        networkMonitor = NetworkMonitor()
        viewModel = CurrencyConverterViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        networkMonitor = nil
        super.tearDown()
    }
    
    func testFetchSymbols() async throws {
        viewModel.isConnected = true
        
        await viewModel.fetchSymbols()
        
        XCTAssertFalse(viewModel.symbols.isEmpty, "Symbols should not be empty")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }
    
    func testFetchExchangeRates() async throws {
        viewModel.isConnected = true
        viewModel.baseCurrency = "EUR"
        
        await viewModel.fetchExchangeRates()
        
        XCTAssertFalse(viewModel.exchangeRates.isEmpty, "Exchange rates should not be empty")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }
    
    func testConvertCurrency() {
        viewModel.amount = "100"
        viewModel.baseCurrency = "EUR"
        viewModel.targetCurrency = "USD"
        viewModel.exchangeRates = ["EUR": 1.0, "USD": 1.2]
        
        viewModel.convertCurrency()
        
        XCTAssertEqual(viewModel.convertedAmount, "120.00", "Converted amount should be 120.00")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil")
    }
    
    func testNoInternetConnection() async throws {
        viewModel.isConnected = false
        
        await viewModel.refreshData()
        
        XCTAssertEqual(viewModel.errorMessage, "No internet connection. Please check your network settings.", "Error message should indicate no internet connection")
    }
}
