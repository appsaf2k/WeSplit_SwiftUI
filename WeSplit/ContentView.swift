//
//  ContentView.swift
//  WeSplit
//
//  Created by @andreev2k on 23.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double? = nil
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15
    @FocusState private var focused: Bool
    @State private var currency = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Сумма чека", value: $checkAmount, format: currency)
                    .keyboardType(.decimalPad)
                    .focused($focused)
                    
                    
                    Picker("Количество людей", selection: $numberOfPeople) {
                        ForEach(2..<21) {
                            Text("\($0) чел.")
                        }
                    }
                }
                
                Section {
                    Picker("Сумма чаевых:", selection: $tipPercentage) {
                        ForEach(0..<26) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("Сколько хочите оставить чаевых?")
                }
                
                Section {
                    Text(totalPerPerson(), format: currency)
                } header: {
                    Text("Сумма на человека:")
                }
                
                Section {
                    Text(totalAmount(), format: currency)
                } header: {
                    Text("Общая сумма:")
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        focused = false
                    }
                }
            }
        }
    }
    
    func totalPerPerson() -> Double {
        let countPeople = Double(numberOfPeople + 2)
        let amountPerson = checkAmount ?? 0.0 * countPeople
        let percentage = (amountPerson / 100) * Double(tipPercentage)
        let totalPerPerson = amountPerson + percentage
        let amountPerPerson = totalPerPerson / countPeople
        
        return amountPerPerson
    }
    
    func totalAmount() -> Double {
        let countPeople = Double(numberOfPeople + 2)
        let amountPerson = checkAmount ?? 0.0 * countPeople
        let percentage = (amountPerson / 100) * Double(tipPercentage)
        let totalAmount = amountPerson + percentage
        
        return totalAmount
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
