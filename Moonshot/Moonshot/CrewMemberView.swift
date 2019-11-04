//
//  CrewMemberView.swift
//  Moonshot
//
//  Created by Emilio Schepis on 04/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct CrewMemberView: View {
    let astronaut: Astronaut
    let role: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(self.astronaut.id)
                 .resizable()
                    .scaledToFill()
                 .frame(width: 60, height: 60)
                 .clipShape(Circle())
                 .overlay(Circle().stroke(self.role == "Commander" ? Color.yellow : Color.primary, lineWidth: 2))
                 .shadow(color: self.role == "Commander" ? .yellow : .primary, radius: 8)
            
            VStack(alignment: .leading) {
                Text(astronaut.name)
                    .font(.headline)
                Text(role)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
