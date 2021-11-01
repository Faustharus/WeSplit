//
//  Split.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 28/10/2021.
//

import Foundation
import SwiftUI

class Split: ObservableObject {
    @Published var historics: [Historic] = [] {
        didSet {
            saveSplit()
        }
    }
    let historicKeys: String = "historic"
    
    init() {
        getItems()
    }
    
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: historicKeys),
            let savedSplit = try? JSONDecoder().decode([Historic].self, from: data)
        else {
            return
        }
        self.historics = savedSplit
    }
    
    func addSplit(amount: Double, peopleCount: Int, percent: Int) {
        let newSplit = Historic(amount: amount, peopleCount: peopleCount, percentChoosed: percent)
        historics.append(newSplit)
    }
    
    func saveSplit() {
        if let encoded = try? JSONEncoder().encode(historics) {
            UserDefaults.standard.set(encoded, forKey: historicKeys)
        }
    }
    
    func deleteSplit(indexSet: IndexSet) {
        historics.remove(atOffsets: indexSet)
    }
    
    func deleteAllSplit() {
        historics.removeAll()
    }
    
}
