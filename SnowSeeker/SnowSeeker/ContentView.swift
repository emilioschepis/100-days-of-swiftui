//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Emilio Schepis on 05/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var layoutVertically = false
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
        .onTapGesture {
            self.layoutVertically.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
