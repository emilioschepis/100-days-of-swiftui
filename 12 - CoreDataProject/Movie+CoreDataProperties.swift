//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Emilio Schepis on 22/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    var wrappedTitle: String {
        return title ?? "Unknown title"
    }
    
    var wrappedDirector: String {
        return director ?? "Unknown director"
    }

}
