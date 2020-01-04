//
//  Result+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var rolls: NSSet?
    
    var wrappedID: UUID { id ?? UUID() }
    var wrappedTimestamp: Date { timestamp ?? Date() }
    var wrappedRolls: [Dice] {
        let rollsSet = rolls as? Set<Dice> ?? []
        return Array(rollsSet)
    }

}

// MARK: Generated accessors for rolls
extension Result {

    @objc(addRollsObject:)
    @NSManaged public func addToRolls(_ value: Dice)

    @objc(removeRollsObject:)
    @NSManaged public func removeFromRolls(_ value: Dice)

    @objc(addRolls:)
    @NSManaged public func addToRolls(_ values: NSSet)

    @objc(removeRolls:)
    @NSManaged public func removeFromRolls(_ values: NSSet)

}
