//
//  ContentView.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Person.entity(), sortDescriptors: [
        NSSortDescriptor(key: "name", ascending: true)
    ]) var people: FetchedResults<Person>
    @State private var showingImagePicker = false
    @State private var showingPersonForm = false
    @State private var inputImage: UIImage?
    
    var addButton: some View {
        Button(action: {
            self.showingImagePicker = true
        }) {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: showPersonForm) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(people, content: PersonRowView.init)
                    .onDelete(perform: deletePeople)
            }
            .navigationBarTitle("MeetUI")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .sheet(isPresented: $showingPersonForm) {
                // Safe because we guard let?
                PersonFormView(inputImage: self.inputImage!)
                    .environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deletePeople(at offsets: IndexSet) {        
        for index in offsets {
            moc.delete(people[index])
            FileManager.default.deleteImage(at: people[index].wrappedID.uuidString)
        }
        try? moc.save()
    }
    
    func showPersonForm() {
        guard inputImage != nil else { return }
        
        showingPersonForm = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
