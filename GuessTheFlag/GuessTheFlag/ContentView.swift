//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Emilio Schepis on 13/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.showingAlert.toggle()
            }) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("Tap me to alert!")
                }
                .foregroundColor(.red)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("SwiftUI"), message: Text("[Day 20/100] #100DaysOfSwiftUI"), dismissButton: .default(Text("OK")))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
