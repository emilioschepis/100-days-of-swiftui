//
//  UserTagsView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserTagsView: View {
    let tags: [String]
    
    func generateRandomColor() -> Color {
        return Color(red: Double.random(in: 0...1),
                     green: Double.random(in: 0...1),
                     blue: Double.random(in: 0...1))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text(tag.uppercased())
                        .font(.caption)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(self.generateRandomColor())
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct UserTagsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTagsView(tags: [])
    }
}
