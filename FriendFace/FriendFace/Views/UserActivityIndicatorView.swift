//
//  UserActivityIndicatorView.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct UserActivityIndicatorView: View {
    let active: Bool
    
    var body: some View {
        Circle()
            .foregroundColor(active ? .green : .gray)
            .frame(width: 15, height: 15, alignment: .center)
    }
}

struct UserActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        UserActivityIndicatorView(active: true)
    }
}
