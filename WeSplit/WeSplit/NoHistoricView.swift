//
//  NoHistoricView.swift
//  WeSplit
//
//  Created by Damien Chailloleau on 30/10/2021.
//

import SwiftUI

struct NoHistoricView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("No Split")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                
                Text(
                """
                This is your historic, it allow to check all of your Split Operation. \n
                When you'll add your first Split ; you'll see those in details with Number of Persons, the Amount and when did you stored your Split Op. \n
                - If you want to see the more details, tap on the desired Split Operation
                - If you want to delete one operation specifically, swipe on right
                """
                )
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
            }
        }
    }
}

struct NoHistoricView_Previews: PreviewProvider {
    static var previews: some View {
        NoHistoricView()
    }
}
