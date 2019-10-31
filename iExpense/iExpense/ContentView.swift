//
//  ContentView.swift
//  iExpense
//
//  Created by Emilio Schepis on 31/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    let name: String
    
    var body: some View {
        VStack {
            Text("Hello, \(name)")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = UserDefaults.standard.integer(forKey: "number")
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                    UserDefaults.standard.set(self.currentNumber, forKey: "number")
                }
                Button("Show sheet") {
                    self.showingSheet.toggle()
                }
            }
            .navigationBarItems(leading: EditButton())
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "@emilioschepis")
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
