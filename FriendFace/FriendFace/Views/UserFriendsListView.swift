//
//  UserFriendsListView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CoreData

struct UserFriendsListView: View {
    @Environment(\.managedObjectContext) var moc
    
    let friends: [Friend]
    
    func getFriendUser(friend: Friend) -> User {
        let request: NSFetchRequest = User.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", friend.wrappedID)
        
        guard let users = try? moc.fetch(request) else {
            return User()
        }
        
        return users.first ?? User()
    }
    
    var body: some View {
        List(friends, id: \.wrappedID) { friend in
            NavigationLink(destination: UserDetailView(user: self.getFriendUser(friend: friend))) {
                UserRowView(user: self.getFriendUser(friend: friend))
            }
        }
    }
}

struct UserFriendsListView_Previews: PreviewProvider {
    static var previews: some View {
        UserFriendsListView(friends: [])
    }
}
