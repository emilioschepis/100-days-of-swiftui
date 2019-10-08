//
//  ContentView.swift
//  WeSplit
//
//  Created by Emilio Schepis on 08/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        Picker("Select your student", selection: $selectedStudent) {
            ForEach(0 ..< students.count) {
                Text(self.students[$0])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
