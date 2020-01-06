//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Emilio Schepis on 10/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var habits: [Habit]
    @State private var title = ""
    @State private var description = ""
    
    func saveHabit() {
        let habit = Habit(title: title, description: description)
        habits.append(habit)
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("New habit")
            .navigationBarItems(trailing: Button(action: saveHabit) {
                Text("Save")
            })
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(habits: Binding.constant([]))
    }
}
