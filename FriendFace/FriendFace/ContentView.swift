//
//  ContentView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var usersObservable: UsersObservable
    
    var body: some View {
        NavigationView {
            Group {
                if usersObservable.loading {
                    Circle()
                } else {
                    List(usersObservable.users, rowContent: UserRowView.init)
                }
            }
            .navigationBarTitle("FriendFace")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
