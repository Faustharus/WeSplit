//
//  WeSplitApp.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 27/10/2021.
//

import SwiftUI

@main
struct WeSplitApp: App {
    
    @StateObject var split = Split()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(Split())
        }
    }
}
