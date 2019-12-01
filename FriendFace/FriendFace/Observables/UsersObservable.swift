//
//  UsersObservable.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

class UsersObservable: ObservableObject {
    @Published var users = [User]()
    @Published var loading = false
    @Published var error: Error?
    
    init() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        self.loading = true
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                self.loading = false
                self.error = error
                
                guard let data = data else {
                    self.users = []
                    return
                }
                                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let decodedUsers = try decoder.decode([User].self, from: data)
                    self.users = decodedUsers.sorted(by: { u1, u2 in u1.name < u2.name })
                } catch {
                    self.error = error
                }
            }
        }.resume()
    }
}
