//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Emilio Schepis on 16/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Prominent title")
                .prominentTitleStyle()
            GridStack(rows: 3, columns: 3, spacing: 30) { row, col in
                Image(systemName: "\(row * 3 + col + 1).circle")
                    .font(.largeTitle)
            }
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let spacing: CGFloat?
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0 ..< rows) { row in
                HStack(spacing: self.spacing) {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func prominentTitleStyle() -> some View {
        self.modifier(ProminentTitle())
    }
}
