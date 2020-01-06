//
//  ContentView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ]) var users: FetchedResults<User>
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List(users, id: \.wrappedID, rowContent: UserRowView.init)
                .navigationBarTitle("FriendFace")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
