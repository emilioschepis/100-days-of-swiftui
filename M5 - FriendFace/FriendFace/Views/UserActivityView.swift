//
//  UserActivityView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserActivityView: View {
    let isActive: Bool
    
    var body: some View {
        Circle()
            .frame(width: 10, height: 10, alignment: .center)
            .foregroundColor(isActive ? .green : .gray)
    }
}

struct UserActivityView_Previews: PreviewProvider {
    static var previews: some View {
        UserActivityView(isActive: true)
    }
}
