//
//  ContentView.swift
//  HotProspects
//
//  Created by Emilio Schepis on 22/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
