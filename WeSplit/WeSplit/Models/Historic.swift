//
//  Historic.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 28/10/2021.
//

import Foundation

struct Historic: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var amount: Double
    var peopleCount: Int
    var percentChoosed: Int
    var dateOfSplit = Date()
}
