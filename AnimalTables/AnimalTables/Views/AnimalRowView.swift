//
//  AnimalRowView.swift
//  AnimalTables
//
//  Created by Emilio Schepis on 30/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct AnimalRowView: View {
    @Binding var isAnimating: Bool
    
    let count: Int
    let animal: String
    
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { _ in
                Image(self.animal)
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .rotation3DEffect(.degrees(self.isAnimating ? 0 : 360), axis: (x: 0, y: 0, z: 1))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        
    }
}
