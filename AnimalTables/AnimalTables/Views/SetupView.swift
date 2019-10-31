//
//  SetupView.swift
//  AnimalTables
//
//  Created by Emilio Schepis on 29/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct SetupView: View {
    @Binding var tables: Int
    @Binding var quizzesCount: Int
    @Binding var settingUp: Bool
    
    private let quizzesLabels = ["5", "10", "20", "All"]
    
    func beginQuizzes() {
        self.settingUp = false
    }
    
    var body: some View {
        Form {
            Section(header: Text("How many tables do you want to play with?")) {
                Stepper("\(tables) tables", value: $tables, in: 2...12)
            }
            
            Section(header: Text("How many quizzes do you want to be given?")) {
                Picker("", selection: $quizzesCount) {
                    ForEach(0..<quizzesLabels.count) {
                        Text(self.quizzesLabels[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button(action: self.beginQuizzes) {
                Text("I'm ready!")
            }
        }
    }
}
