//
//  HistoricRow.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 28/10/2021.
//

import SwiftUI

struct HistoricRow: View {
    
    @State private var isVisible: Bool = false
    
    let historic: Historic
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .overlay(
                    HStack {
                        VStack {
                            Text("\(historic.dateOfSplit, formatter: itemFormatter)")
                                .padding(.vertical, 5)
                            HStack {
                                Text("Amount :")
                                Text("\(historic.amount, specifier: "%.2f") €")
                                
                                Text("|")
                                
                                Text("Percentage :")
                                Text("\(historic.percentChoosed) %")
                            }
                            HStack {
                                Text("Number of Persons :")
                                Text("\(historic.peopleCount)")
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isVisible.toggle()
                }
                .alert(isPresented: $isVisible) {
                    Alert(
                        title: Text("Details"),
                        message: Text(
                            """
                            Amount/Person: \(billPerPerson, specifier: "%.2f") €
                            Tips/Person: \(billWithTips - billPerPerson, specifier: "%.2f") €
                            """
                        ),
                        dismissButton: .default(Text("Continue")))
                }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    return formatter
}()

struct HistoricRow_Previews: PreviewProvider {
    
    static var split1 = Historic(amount: 300, peopleCount: 3, percentChoosed: 10)
    
    static var previews: some View {
        NavigationView {
            HistoricRow(historic: split1)
                .environmentObject(Split())
        }
    }
}


// MARK: - Computed Properties
extension HistoricRow {
    
    // Make operation for the bill per person
    var billPerPerson: Double {
        let price = historic.amount
        let peopleCount = Double(historic.peopleCount)
        
        let result = price / peopleCount
        
        return result
    }
    
    
    // Make operation for the bill per person with the tips
    var billWithTips: Double {
        let price = historic.amount
        let peopleCount = Double(historic.peopleCount)
        let currentPercent = Double(historic.percentChoosed)
        
        let priceDivided = price / peopleCount
        let priceTiped = priceDivided * (currentPercent / 100)
        let result = priceDivided + priceTiped
        
        return result
    }
    
}
