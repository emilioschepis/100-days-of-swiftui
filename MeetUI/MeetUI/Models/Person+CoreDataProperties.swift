//
//  Person+CoreDataProperties.swift
//  MeetUI
//
//  Created by Emilio Schepis on 13/12/2019.
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
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var info: String?
    
    var wrappedID: UUID { id ?? UUID() }
    var wrappedName: String { name ?? "Unknown name" }
    var wrappedInfo: String { info ?? "No info" }

}

extension Person: Identifiable {
    
}
