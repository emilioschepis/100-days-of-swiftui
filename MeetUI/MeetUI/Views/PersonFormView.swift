//
//  PersonFormView.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct PersonFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    
    let inputImage: UIImage
    let uuid = UUID()
    
    var saveButton: some View {
        Button("Save") {
            FileManager.default.saveImage(self.inputImage, to: self.uuid.uuidString) { error in
                if let error = error {
                    print(error)
                } else {
                    let person = Person(context: self.moc)
                    person.id = self.uuid
                    person.name = self.name
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Photo")) {
                    Image(uiImage: inputImage)
                        .resizable()
                        .frame(height: 200)
                }
                
                Section(header: Text("Info")) {
                    TextField("Name", text: $name)
                }
            }
            .navigationBarTitle(Text("Nice to meet you!"), displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
        }
    }
}

struct PersonFormView_Previews: PreviewProvider {
    static var previews: some View {
        PersonFormView(inputImage: UIImage())
    }
}
