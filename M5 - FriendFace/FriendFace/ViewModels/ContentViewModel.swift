//
//  ContentViewModel.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

struct CodableFriend: Codable {
    let id: String
    let name: String
}

struct CodableUser: Codable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [CodableFriend]
}

class ContentViewModel: ObservableObject {
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let users: [User] = try self.moc.fetch(User.fetchRequest())
                let decodedUsers = try decoder.decode([CodableUser].self, from: data)
                
                DispatchQueue.main.async {
                    for du in decodedUsers {
                        if users.first(where: { $0.id == du.id }) != nil {
                            continue
                        }
                        
                        let user = User(context: self.moc)
                        user.id = du.id
                        user.isActive = du.isActive
                        user.name = du.name
                        user.age = Int16(du.age)
                        user.company = du.company
                        user.email = du.email
                        user.address = du.address
                        user.about = du.about
                        user.registered = du.registered
                        user.tags = du.tags
                        
                        for df in du.friends {
                            let friend = Friend(context: self.moc)
                            friend.id = df.id
                            friend.name = df.name
                            user.addToFriends(friend)
                        }
                    }
                    
                    try? self.moc.save()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
