//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var numberOfDice: Int
    @Binding var diceSides: Int
    
    let possibleDiceSides = [4, 6, 8, 10, 12, 20]
    
    var doneButton: some View {
        Button("Done") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Number of dice")) {
                    Stepper("\(numberOfDice)", value: $numberOfDice, in: 2...10)
                }
                Section(header: Text("Dice sides")) {
                    Picker(selection: $diceSides, label: Text("Sides")) {
                        ForEach(possibleDiceSides, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: doneButton)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(numberOfDice: .constant(2),
                     diceSides: .constant(6))
    }
}
