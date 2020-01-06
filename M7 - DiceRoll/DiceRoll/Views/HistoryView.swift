//
//  HistoryView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Result.entity(), sortDescriptors: [
        NSSortDescriptor(key: "timestamp", ascending: false)
    ]) var results: FetchedResults<Result>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results, id: \.wrappedID) { result in
                    ResultView(result: result)
                }
                .onDelete(perform: removeRolls)
            }
            .navigationBarTitle("History")
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRolls(at offsets: IndexSet) {
        offsets.forEach { index in
            moc.delete(results[index])
        }
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
