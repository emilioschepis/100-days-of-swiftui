//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Emilio Schepis on 01/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?
    
    var wrappedID: String { id ?? "" }
    var wrappedName: String { name ?? "" }
    var wrappedAge: Int { Int(age) }
    var wrappedCompany: String { company ?? "" }
    var wrappedEmail: String { email ?? "" }
    var wrappedAddress: String { address ?? "" }
    var wrappedAbout: String { about ?? "" }
    var wrappedRegistered: Date { registered ?? Date() }
    var wrappedTags: [String] {
        return tags ?? []
    }
    var wrappedFriends: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted(by: { $0.wrappedName < $1.wrappedName })
    }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
