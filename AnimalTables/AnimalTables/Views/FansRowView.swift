//
//  FansRowView.swift
//  AnimalTables
//
//  Created by Emilio Schepis on 30/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct FansRowView: View {
    @Binding var isCheering: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...10, id: \.self) { number in
                Image("frog")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .offset(x: 0, y: self.isCheering ? -20 : 20)
                    .scaleEffect(self.isCheering ? 1.5 : 1)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.1 * Double(number)))

            }
        }
    }
}
