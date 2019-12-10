//
//  Person+CoreDataProperties.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    
    var wrappedID: UUID { id ?? UUID() }
    var wrappedName: String { name ?? "Unknown name" }
}

extension Person: Identifiable {
    
}
