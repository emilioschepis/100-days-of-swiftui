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
    
    var body: some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            HStack(spacing: 12) {
                UserActivityView(isActive: user.isActive)
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.wrappedName)
                        .font(.headline)
                    Text(user.wrappedAbout)
                        .lineLimit(1)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User())
    }
}
