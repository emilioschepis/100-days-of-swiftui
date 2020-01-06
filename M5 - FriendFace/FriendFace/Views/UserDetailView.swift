//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var firstName: String {
        String(user.wrappedName.split(separator: " ").first ?? Substring())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text("About \(firstName)").font(.headline)
                Text(user.wrappedAbout)
            }
            
            VStack(alignment: .leading) {
                Text("Info").font(.headline)
                HStack {
                    Image(systemName: "briefcase.fill")
                        .foregroundColor(.accentColor)
                    Text("Works at \(user.wrappedCompany)")
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.accentColor)
                    Text(user.wrappedEmail)
                        .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.accentColor)
                    Text(user.wrappedAddress)
                        .font(.subheadline)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Interests").font(.headline)
                UserTagsListView(tags: user.wrappedTags)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Friends").font(.headline)
                NavigationLink(destination: UserFriendsListView(friends: user.wrappedFriends)) {
                    Text("\(firstName) has \(user.wrappedFriends.count) friends")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text(user.wrappedName), displayMode: .inline)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
