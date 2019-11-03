//
//  ContentView.swift
//  Moonshot
//
//  Created by Emilio Schepis on 03/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let detail: String
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    Image("SwiftUI")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                }
            }
        }
        .navigationBarTitle("Screen #\(detail)")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<100) { num in
                NavigationLink(destination: DetailView(detail: "\(num)")) {
                    Text("\(num)")
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
