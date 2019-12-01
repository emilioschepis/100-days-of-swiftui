//
//  UserFriendsListView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserFriendsListView: View {
    @EnvironmentObject var usersObservable: UsersObservable
    
    let name: String
    let friends: [Friend]
    
    func getFriendUser(friend: Friend) -> User? {
        return usersObservable.users.first(where: { u in u.id == friend.id })
    }
    
    var body: some View {
        List(friends) { friend in
            NavigationLink(destination: UserDetailView(user: self.getFriendUser(friend: friend)!)) {
                Text(friend.name)
            }
        }
        .navigationBarTitle(Text("\(name)'s friends"), displayMode: .inline)
    }
}

struct UserFriendsListView_Previews: PreviewProvider {
    static var previews: some View {
        UserFriendsListView(name: "Emilio", friends: [])
    }
}
