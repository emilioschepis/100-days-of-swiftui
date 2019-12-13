//
//  PersonFormView.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PersonFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    @State private var info = ""
    
    let inputImage: UIImage
    let location: CLLocationCoordinate2D?
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
                    person.latitude = self.location?.latitude ?? 0
                    person.longitude = self.location?.longitude ?? 0
                    person.info = self.info
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Info")) {
                        TextField("Name", text: $name)
                        
                        TextField("Info", text: $info)
                    }
                    
                    Image(uiImage: inputImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            .navigationBarTitle(Text("Nice to meet you!"), displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
        }
    }
}

struct PersonFormView_Previews: PreviewProvider {
    static var previews: some View {
        PersonFormView(inputImage: UIImage(), location: nil)
    }
}
