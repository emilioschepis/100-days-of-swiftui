//
//  ContentView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Text("Dice")
                    Image(systemName: "dot.square.fill")
                }
            HistoryView()
                .tabItem {
                    Text("History")
                    Image(systemName: "clock.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
