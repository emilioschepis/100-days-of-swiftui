//
//  PersonDetailView.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct PersonDetailView: View {
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
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Spacer()
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
