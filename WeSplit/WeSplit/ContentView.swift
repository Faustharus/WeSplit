//
//  ContentView.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 27/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var split: Split
    
    @State private var amount: Double = 0
    @State private var nbOfPeople: Int = 1
    @State private var currentPosition: Int = 0
    
    @State private var isVisible: Bool = false
    @State private var isAdded: Bool = false
    
    @FocusState private var amountIsFocused: Bool
    
    let percentage = [0, 10, 15, 20, 25]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    formSection
                )
                .overlay(
                    resetButton
                )
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $isAdded) {
                        Alert(title: Text("Store this Split ?"), message: Text("You're about to store the Split Operation"), primaryButton: .default(Text("Resume"), action: saveItem), secondaryButton: .cancel(Text("Cancel"), action: resetField))
                }
                .popover(isPresented: $isVisible) {
                    HistoricSplit()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        historicButton
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        addButton
                    }
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .environmentObject(Split())
        }
    }
}


// MARK: - Computed Properties & Func
extension ContentView {
    
    // Make operation for the bill per person
    var billPerPerson: Double {
        let price = amount
        let peopleCount = Double(nbOfPeople)
        
        let result = price / peopleCount
        
        return result
    }
    
    // Make operation for the bill per person with the tips
    var billWithTips: Double {
        let price = amount
        let peopleCount = Double(nbOfPeople)
        let currentPercent = Double(percentage[currentPosition])
        
        let priceDivided = price / peopleCount
        let priceTiped = priceDivided * (currentPercent / 100)
        let result = priceDivided + priceTiped
        
        return result
    }
    
    // Save the Split Operation
    func saveItem() {
        split.addSplit(amount: amount, peopleCount: nbOfPeople, percent: percentage[currentPosition])
        resetField()
    }
    
    // Reset the Field of the App
    func resetField() {
        self.amount = 0
        self.nbOfPeople = 1
        self.currentPosition = 0
    }
    
}


// MARK: - View Components
extension ContentView {
    
    private var formSection: some View {
        Form {
            // MARK: - Top
            Section(header: Text("How much do you have to pay ?").foregroundColor(.white)) {
                TextField("", value: $amount, format: .currency(code: "EUR"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            }
            
            Section(header: Text("How many peoples ?").foregroundColor(.white)) {
                TextField("", value: $nbOfPeople, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            }
            
            Section(header: Text("How much tips do you want to give ?").foregroundColor(.white)) {
                Picker("", selection: $currentPosition) {
                    ForEach(0 ..< percentage.count) {
                        Text("\(percentage[$0])%")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            // MARK: - Middle
            Section(header: Text("Amount Per Person").foregroundColor(.white)) {
                Text("\(billPerPerson, specifier: "%.2f") €")
            }
            
            Section(header: Text("Amount Per Person with Tips").foregroundColor(.white)) {
                Text("\(billWithTips, specifier: "%.2f") €")
            }
        }
    }
    
    private var resetButton: some View {
        VStack {
            // MARK: - Reset Button
            Spacer()
            Button(action: {
                resetField()
            }) {
                Text("Reset")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.red))
                    .cornerRadius(25.0)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
            }
        }
    }
    
    // MARK: - Left Navigation Button - Historic
    private var historicButton: some View {
        VStack {
            Button(action: {
                self.isVisible.toggle()
            }) {
                Image(systemName: "list.bullet")
                    .foregroundColor(.yellow)
            }
        }
    }
    
    // MARK: - Right Navigation Button - Add
    private var addButton: some View {
        VStack {
            Button(action: {
                self.isAdded.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.yellow)
            }
        }
    }
}
