//
//  MiniDiceView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct MiniDiceView: View {
    let roll: Int
    
    var body: some View {
        Text("\(roll)")
            .bold()
            .frame(width: 30, height: 30)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 3)))
            .padding(4)
    }
}

struct MiniDiceView_Previews: PreviewProvider {
    static var previews: some View {
        MiniDiceView(roll: 0)
    }
}
