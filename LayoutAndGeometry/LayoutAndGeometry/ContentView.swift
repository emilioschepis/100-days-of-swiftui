//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Emilio Schepis on 27/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndname) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndname) { d in d[VerticalAlignment.top] }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndname) { d in d[VerticalAlignment.bottom] }
                    .font(.largeTitle)
            }
        }
        .background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndname = VerticalAlignment(MidAccountAndName.self)
}
