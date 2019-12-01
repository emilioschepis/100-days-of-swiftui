//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject var usersObservable: UsersObservable
    
    let user: User
    
    var firstName: String {
        if let firstName = user.name.split(separator: " ").first {
            return String(firstName)
        }
        
        return user.name
    }
    
    var friendsView: some View {
        UserFriendsListView(name: self.firstName,
                            friends: self.user.friends)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Group {
                Text("About me")
                    .font(.headline)
                Text(user.about)
                    .foregroundColor(.secondary)
            }
            
            Group {
                Text("Info")
                    .font(.headline)
                HStack {
                    Image(systemName: "briefcase.fill")
                        .foregroundColor(.accentColor)
                    Text("Works at \(user.company)")
                }
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.accentColor)
                    Text("\(user.address)")
                }
            }
            
            Group {
                Text("Interests")
                    .font(.headline)
                UserTagsView(tags: user.tags)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Friends")
                    .font(.headline)
                NavigationLink(destination: friendsView) {
                    Text("\(firstName) has \(user.friends.count) friends.")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(user.name), displayMode: .inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
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
        UserDetailView(user: user)
    }
}
