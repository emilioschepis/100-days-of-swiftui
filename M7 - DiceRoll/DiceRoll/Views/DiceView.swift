//
//  DiceView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    let roll: Int
    let sides: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text("\(roll)")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .frame(width: 80, height: 80)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 3)))
            }
            Text("\(sides)")
                .font(.subheadline)
                .offset(x: -4, y: 4)
        }
        .frame(width: 100, height: 100)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(roll: 0, sides: 10)
    }
}
