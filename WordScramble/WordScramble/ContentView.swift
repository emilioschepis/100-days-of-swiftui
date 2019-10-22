//
//  ContentView.swift
//  WordScramble
//
//  Created by Emilio Schepis on 22/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var words: [String] = []
    
    func loadWords() {
        guard let url = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            // TODO: Handle error
            return
        }
        
        guard let content = try? String(contentsOf: url) else {
            // TODO: Handle error
            return
        }
        
        words = content.components(separatedBy: .newlines)
    }
    
    var body: some View {
        VStack {
            ForEach(words, id: \.self) {
                Text($0)
            }
        }
        .onAppear(perform: loadWords)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
