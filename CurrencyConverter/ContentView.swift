//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Dao Anh Phuc on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack{
                if !viewModel.isConnected {
                    Text("No internet connection. Please check your network settings.")
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    if viewModel.isLoading {
                        ProgressView("Fetching data, just for you. Hang tight...")
                    }
                    
                    else {
                        
                        Form{
                            Section(header: Text("Convert a currency")){
                                TextField("Enter an amount", text: $viewModel.amount).keyboardType(.decimalPad)                                    .accessibilityIdentifier("amountTextField")
                                
                                
                                Picker("From:", selection: $viewModel.baseCurrency) {
                                    ForEach(Array(viewModel.symbols.keys), id: \.self){
                                        currency in Text(currency)
                                    }
                                }.pickerStyle(.menu)
                                    .accessibilityIdentifier("fromPicker")
                                
                                
                                Picker("To:", selection: $viewModel.targetCurrency) {
                                    ForEach(Array(viewModel.symbols.keys), id: \.self){
                                        currency in Text(currency)
                                    }
                                }.pickerStyle(.menu).accessibilityIdentifier("toPicker")
                            }
                            
                            Section(header: Text("Decimal precision"), footer: Text("Rate precision: \(viewModel.decimalPlaces)")){
                                Slider(value: Binding (
                                    get: {
                                        Double(viewModel
                                            .decimalPlaces)},
                                    set: {
                                        viewModel.decimalPlaces=Int($0)
                                    }
                                ), in: 0...4, step: 1)}
                            
                            
                            Section(header: Text("Conversions"), footer: Text(viewModel.errorMessage ?? "")
                                .foregroundColor(.red)
                                .font(.footnote)
                                .padding(.top, 5)
                            ){
                                Text(viewModel.convertedAmount.isEmpty && viewModel.errorMessage != nil ? "Empty..." : "\(viewModel.convertedAmount) \(viewModel.targetCurrency)")
                                    .padding(10)
                                
                            }
                        }
                        .navigationBarTitle(Text("Currency Converter"))
                        
                        
                        HStack {
                            Button(action: {
                                viewModel.convertCurrency()
                            }, label: {
                                Text("Convert")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(viewModel.amount.isEmpty ? Color.accentColor : Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            })
                            .accessibilityIdentifier("convertButton")
                        }
                        .disabled(viewModel.amount.isEmpty)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
