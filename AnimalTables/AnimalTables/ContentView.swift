//
//  ContentView.swift
//  AnimalTables
//
//  Created by Emilio Schepis on 28/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var settingUp = true
    @State private var tables = 2
    @State private var quizzesCount = 0
    
    private let quizzesValues = [5, 10, 20, .max]
    
    var body: some View {
        NavigationView {
            Group {
                if (settingUp) {
                    SetupView(tables: $tables,
                              quizzesCount: $quizzesCount,
                              settingUp: $settingUp)
                }
                
                if (!settingUp) {
                    QuizView(tables: $tables,
                             settingUp: $settingUp,
                             quizzesCount: quizzesValues[quizzesCount])
                }
            }
            .navigationBarTitle("AnimalTables")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
