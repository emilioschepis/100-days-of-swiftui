//
//  UserTagsListView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserTagsListView: View {
    let tags: [String]
    
    func randomColor() -> Color {
        let red = Double.random(in: 0...0.5)
        let green = Double.random(in: 0...0.5)
        let blue = Double.random(in: 0...0.5)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(self.randomColor().opacity(0.75))
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct UserTagsListView_Previews: PreviewProvider {
    static var previews: some View {
        UserTagsListView(tags: [])
    }
}
