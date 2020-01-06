//
//  ResultView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var result: Result
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var total: Int {
        result.wrappedRolls.reduce(0) {
            $0 + $1.wrappedRoll
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.dateFormatter.string(from: result.wrappedTimestamp))
                .font(.headline)
            Text("You rolled a total of \(total).")
                .font(.subheadline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(result.wrappedRolls.sorted { $0.wrappedID.uuidString < $1.wrappedID.uuidString },
                            id: \.wrappedID) {
                                MiniDiceView(roll: $0.wrappedRoll)
                    }
                }
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(result: Result())
    }
}
