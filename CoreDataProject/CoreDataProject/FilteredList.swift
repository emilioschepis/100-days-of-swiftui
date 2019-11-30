//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Emilio Schepis on 30/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var results: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                            sortDescriptors: [],
                                            predicate: NSPredicate(format: "%K BEGINSWITH[c] %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(results, id: \.self) { result in
            self.content(result)
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "lastName", filterValue: "A", content: { _ in Text("") })
    }
}
