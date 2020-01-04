//
//  Dice+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//
//

import Foundation
import CoreData


extension Dice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dice> {
        return NSFetchRequest<Dice>(entityName: "Dice")
    }

    @NSManaged public var sides: Int16
    @NSManaged public var roll: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var result: Result?

    var wrappedID: UUID { id ?? UUID() }
    var wrappedSides: Int { Int(sides) }
    var wrappedRoll: Int { Int(roll) }
}
