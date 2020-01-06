//
//  PersonRowView.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct PersonRowView: View {
    @State private var image: Image?
    
    let person: Person
    
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
        NavigationLink(destination: PersonDetailView(person: person)) {
            HStack {
                image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                VStack {
                    Text(person.wrappedName)
                        .font(.headline)
                }
            }
        }
        .frame(height: 60)
        .onAppear(perform: loadImage)
    }
}

struct PersonRowView_Previews: PreviewProvider {
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
