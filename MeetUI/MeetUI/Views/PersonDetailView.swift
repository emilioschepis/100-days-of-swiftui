//
//  PersonDetailView.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PersonDetailView: View {
    @State private var image: Image?
    @State private var showing = 0
    
    let person: Person
    
    var personLocation: CLLocationCoordinate2D {
        .init(latitude: person.latitude, longitude: person.longitude)
    }
    
    func loadImage() {
        FileManager.default.readImage(from: person.wrappedID.uuidString) { (image, error) in
            if let error = error {
                print(error)
            } else if let image = image {
                self.image = Image(uiImage: image)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            Picker(selection: $showing, label: Text("")) {
                Text("Photo").tag(0)
                Text("Location").tag(1)
                Text("Info").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            
            VStack(spacing: 16) {
                if showing == 0 {
                        Text("A photo of \(person.wrappedName).")
                            .font(.caption)
                        
                        image?
                            .resizable()
                            .scaledToFit()
                } else if showing == 1 {
                        Text("You and \(person.wrappedName) met here.")
                            .font(.caption)
                        
                        MapView(location: personLocation)
                            .frame(height: 300)
                } else if showing == 2 {
                        Text("Some info about \(person.wrappedName).")
                            .font(.caption)
                        
                        Text(person.wrappedInfo)
                }
            }.padding()
        }
        .navigationBarTitle(person.wrappedName)
        .onAppear(perform: loadImage)
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static let person: Person = {
        let person = Person()
        person.id = UUID()
        person.name = "Test person"
        return person
    }()
    
    static var previews: some View {
        PersonRowView(person: person)
    }
}
