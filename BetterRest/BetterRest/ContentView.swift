//
//  ContentView.swift
//  BetterRest
//
//  Created by Emilio Schepis on 19/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        Form {
            DatePicker("Wake up at", selection: $wakeUp, in: Date()..., displayedComponents: .hourAndMinute)
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours of sleep")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
