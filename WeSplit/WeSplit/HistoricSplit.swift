//
//  HistoricSplit.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 28/10/2021.
//

import SwiftUI

struct HistoricSplit: View {
    
    @EnvironmentObject var split: Split
    
    @State private var isReset: Bool = false
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        if split.historics.isEmpty {
            NoHistoricView()
                .transition(AnyTransition.opacity.animation(.easeIn))
        } else {
            VStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        VStack {
                            titleSection
                            historicList
                            resetButton
                                .alert(isPresented: $isReset) {
                                    Alert(title: Text("Are you sure ?"), message: Text("You are about to empty the historic"), primaryButton: Alert.Button.default(Text("Confirm"), action: {
                                        split.deleteAllSplit()
                                    }), secondaryButton: .cancel())
                                }
                        }
                    )
            }
        }
    }
}

struct HistoricSplit_Previews: PreviewProvider {
    static var previews: some View {
        HistoricSplit()
            .environmentObject(Split())
    }
}


// MARK: - Components View
extension HistoricSplit {
    
    private var titleSection: some View {
        VStack {
            Text("Your Historic")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical, 20)
        }
    }
    
    private var historicList: some View {
        List {
            ForEach(split.historics) { item in
                HistoricRow(historic: item)
            }
            .onDelete(perform: split.deleteSplit)
        }
        .padding(.horizontal, -15)
    }
    
    private var resetButton: some View {
        Button(action: {
            self.isReset.toggle()
        }) {
            Text("Empty Historic")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color(.red))
                .cornerRadius(25.0)
                .padding(.horizontal, 5)
        }
    }
    
}
