//
//  UserRowView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            HStack(spacing: 12) {
                UserActivityIndicatorView(active: user.isActive)
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.about)
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static let user = User(id: UUID().uuidString,
                           isActive: true,
                           name: "Emilio Schepis",
                           age: 23,
                           company: "ES",
                           address: "My address",
                           about: "I'm doing the 100 days of SwiftUI",
                           registered: Date(),
                           tags: [],
                           friends: [])
    
    static var previews: some View {
        UserRowView(user: user)
    }
}
